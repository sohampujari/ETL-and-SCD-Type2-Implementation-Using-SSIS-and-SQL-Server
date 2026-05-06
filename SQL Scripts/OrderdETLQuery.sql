--CREATE TABLE FactOrders --
CREATE TABLE FactOrders (
    OrderKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT,
    TerritoryKey INT,
    DateKey INT,
    OrderCount INT,
    TotalDue MONEY
);

--JOIN TO ADENTUREWORKS––
INSERT INTO SalesDW.dbo.FactOrders
(CustomerKey, TerritoryKey, DateKey, OrderCount, TotalDue)

SELECT 
    dc.CustomerKey,
    dt.TerritoryKey,
    dd.DateKey,
    1 AS OrderCount,
    soh.TotalDue

FROM AdventureWorks2022.Sales.SalesOrderHeader soh

JOIN SalesDW.dbo.DimCustomer dc
    ON soh.CustomerID = dc.CustomerID

JOIN SalesDW.dbo.DimTerritory dt
    ON soh.TerritoryID = dt.TerritoryID

JOIN SalesDW.dbo.DimDate dd
    ON CAST(CONVERT(VARCHAR(8), soh.OrderDate, 112) AS INT) = dd.DateKey;

    --Verify––
    SELECT TOP 10 * FROM SalesDW.dbo.FactOrders;

