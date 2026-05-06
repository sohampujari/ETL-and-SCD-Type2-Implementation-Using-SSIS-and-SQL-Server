--Create a New Database--
CREATE DATABASE SalesDW;
USE SalesDW;


--Create Dimension Tables--

--DimCustomer--
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

--DimProduct--
CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    SubCategory NVARCHAR(50)
);

--DimTerritory--
CREATE TABLE DimTerritory (
    TerritoryKey INT IDENTITY(1,1) PRIMARY KEY,
    TerritoryID INT,
    TerritoryName NVARCHAR(50),
    Country NVARCHAR(50)
);

--DimDate--
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    OrderDate DATE
);


--Create Fact Table--

--FactSales--
CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT,
    ProductKey INT,
    TerritoryKey INT,
    DateKey INT,
    OrderQuantity INT,
    SalesAmount MONEY
);


-- Load DimCustomer (Extraction + Transformation) --
INSERT INTO SalesDW.dbo.DimCustomer (CustomerID, FirstName, LastName)
SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName
FROM AdventureWorks2022.Sales.Customer c
JOIN AdventureWorks2022.Person.Person p
    ON c.PersonID = p.BusinessEntityID;

    --Verify--
    SELECT * FROM SalesDW.dbo.DimCustomer;


    -- Load DimProduct--
    INSERT INTO SalesDW.dbo.DimProduct (ProductID, ProductName, Category, SubCategory)
SELECT 
    p.ProductID,
    p.Name,
    pc.Name AS Category,
    ps.Name AS SubCategory
FROM AdventureWorks2022.Production.Product p
LEFT JOIN AdventureWorks2022.Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN AdventureWorks2022.Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID;

     --Verify--
    SELECT * FROM SalesDW.dbo.DimProduct;


    --Load DimTerritory--
    INSERT INTO SalesDW.dbo.DimTerritory (TerritoryID, TerritoryName, Country)
SELECT 
    TerritoryID,
    Name,
    CountryRegionCode
FROM AdventureWorks2022.Sales.SalesTerritory;

--Verify--
SELECT * FROM SalesDW.dbo.DimTerritory;


--Load DimDate--
INSERT INTO SalesDW.dbo.DimDate (DateKey, OrderDate)
SELECT DISTINCT 
    CAST(CONVERT(VARCHAR, OrderDate, 112) AS INT) AS DateKey,
    OrderDate
FROM AdventureWorks2022.Sales.SalesOrderHeader;

--Verify--
SELECT * FROM SalesDW.dbo.DimDate;


--Load FactSales--
INSERT INTO SalesDW.dbo.FactSales 
(CustomerKey, ProductKey, TerritoryKey, DateKey, OrderQuantity, SalesAmount)

SELECT 
    dc.CustomerKey,
    dp.ProductKey,
    dt.TerritoryKey,
    dd.DateKey,
    sod.OrderQty,
    sod.LineTotal

FROM AdventureWorks2022.Sales.SalesOrderHeader soh

JOIN AdventureWorks2022.Sales.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID

JOIN SalesDW.dbo.DimCustomer dc
    ON soh.CustomerID = dc.CustomerID

JOIN SalesDW.dbo.DimProduct dp
    ON sod.ProductID = dp.ProductID

JOIN SalesDW.dbo.DimTerritory dt
    ON soh.TerritoryID = dt.TerritoryID

JOIN SalesDW.dbo.DimDate dd
    ON CAST(CONVERT(VARCHAR, soh.OrderDate, 112) AS INT) = dd.DateKey;

    --Verify--
    SELECT TOP 10 * FROM SalesDW.dbo.FactSales;

    TRUNCATE TABLE SalesDW.dbo.DimDate;