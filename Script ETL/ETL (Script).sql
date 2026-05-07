USE DW_Northwind;
GO

---Dim_customer
INSERT INTO Dim_Customer (CustomerID, CompanyName, City, Country)
SELECT CustomerID, CompanyName, City, Country
FROM Northwind.dbo.Customers;

---Dim_product
INSERT INTO Dim_Product (ProductID, ProductName, CategoryName)
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Northwind.dbo.Products p
LEFT JOIN Northwind.dbo.Categories c
ON p.CategoryID = c.CategoryID;

---Dim_employee
INSERT INTO Dim_Employee (EmployeeID, FullName)
SELECT EmployeeID, FirstName + ' ' + LastName
FROM Northwind.dbo.Employees;

---Dim_Shipper
INSERT INTO Dim_Shipper (ShipperID, CompanyName)
SELECT ShipperID, CompanyName
FROM Northwind.dbo.Shippers;

---Dim_date
INSERT INTO Dim_Date (DateKey, FullDate, Year, Month, Day)
SELECT DISTINCT
    CONVERT(INT, FORMAT(OrderDate, 'yyyyMMdd')),
    OrderDate,
    YEAR(OrderDate),
    MONTH(OrderDate),
    DAY(OrderDate)
FROM Northwind.dbo.Orders;

---Cargar Fact Table
INSERT INTO Fact_Sales (
    OrderID,
    ProductID,
    CustomerID,
    EmployeeID,
    ShipperID,
    DateKey,
    Quantity,
    UnitPrice,
    Discount
)

SELECT 
    od.OrderID,
    od.ProductID,
    o.CustomerID,
    o.EmployeeID,
    o.ShipVia,
    CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')),
    od.Quantity,
    od.UnitPrice,
    od.Discount
FROM Northwind.dbo.OrderDetails od
JOIN Northwind.dbo.Orders o
    ON od.OrderID = o.OrderID;