-- Create SCD Dimension Table--

--Step 1 :- CREATE TABLE dbo.DimCustomer--
CREATE TABLE dbo.DimCustomer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,

    CustomerID INT,
    BusinessEntityID INT,

    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmailAddress NVARCHAR(100),
    AddressLine1 NVARCHAR(100),
    City NVARCHAR(50),

    StartDate DATETIME,
    EndDate DATETIME,

    IsCurrent BIT
);


--Step 2:- create staging table--
CREATE TABLE dbo.StgCustomer
(
    CustomerID INT,
    BusinessEntityID INT,

    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmailAddress NVARCHAR(100),
    AddressLine1 NVARCHAR(100),
    City NVARCHAR(50)
);


--Step 3 — Load Staging Table--
TRUNCATE TABLE dbo.StgCustomer;

INSERT INTO dbo.StgCustomer
(
    CustomerID,
    BusinessEntityID,
    FirstName,
    LastName,
    EmailAddress,
    AddressLine1,
    City
)
SELECT
    c.CustomerID,
    c.PersonID AS BusinessEntityID,
    p.FirstName,
    p.LastName,
    ea.EmailAddress,
    a.AddressLine1,
    a.City
FROM Sales.Customer c
INNER JOIN Person.Person p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.EmailAddress ea
    ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress bea
    ON p.BusinessEntityID = bea.BusinessEntityID
LEFT JOIN Person.Address a
    ON bea.AddressID = a.AddressID
WHERE c.PersonID IS NOT NULL;

--Verify--
SELECT TOP 10 * 
FROM dbo.StgCustomer;


--Step 4--
INSERT INTO dbo.DimCustomer
(
    CustomerID,
    BusinessEntityID,
    FirstName,
    LastName,
    EmailAddress,
    AddressLine1,
    City,
    StartDate,
    EndDate,
    IsCurrent
)
SELECT
    CustomerID,
    BusinessEntityID,
    FirstName,
    LastName,
    EmailAddress,
    AddressLine1,
    City,
    GETDATE(),
    NULL,
    1
FROM dbo.StgCustomer;

--Verify--
SELECT TOP 10 *
FROM dbo.DimCustomer;


--Step 5 — Implement SCD Type 2 Logic--
UPDATE dbo.StgCustomer
SET City = 'Mumbai'
WHERE CustomerID = 29485;

--Step 5A — Expire old records--
UPDATE d
SET
    d.EndDate = GETDATE(),
    d.IsCurrent = 0
FROM dbo.DimCustomer d
INNER JOIN dbo.StgCustomer s
    ON d.CustomerID = s.CustomerID
WHERE d.IsCurrent = 1
AND
(
       ISNULL(d.FirstName,'') <> ISNULL(s.FirstName,'')
    OR ISNULL(d.LastName,'') <> ISNULL(s.LastName,'')
    OR ISNULL(d.EmailAddress,'') <> ISNULL(s.EmailAddress,'')
    OR ISNULL(d.AddressLine1,'') <> ISNULL(s.AddressLine1,'')
    OR ISNULL(d.City,'') <> ISNULL(s.City,'')
);

--Step 5B — Insert new changed records--
INSERT INTO dbo.DimCustomer
(
    CustomerID,
    BusinessEntityID,
    FirstName,
    LastName,
    EmailAddress,
    AddressLine1,
    City,
    StartDate,
    EndDate,
    IsCurrent
)
SELECT
    s.CustomerID,
    s.BusinessEntityID,
    s.FirstName,
    s.LastName,
    s.EmailAddress,
    s.AddressLine1,
    s.City,
    GETDATE(),
    NULL,
    1
FROM dbo.StgCustomer s
INNER JOIN dbo.DimCustomer d
    ON s.CustomerID = d.CustomerID
WHERE d.IsCurrent = 0
AND NOT EXISTS
(
    SELECT 1
    FROM dbo.DimCustomer x
    WHERE x.CustomerID = s.CustomerID
    AND x.IsCurrent = 1
);

--Verify history--
SELECT *
FROM dbo.DimCustomer
WHERE CustomerID = 29485
ORDER BY CustomerKey;


--After Visual Code Execution, verify:--
SELECT *
FROM dbo.DimCustomer
WHERE CustomerID = 29485
ORDER BY CustomerKey;