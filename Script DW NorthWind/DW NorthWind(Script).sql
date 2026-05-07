CREATE DATABASE DW_Northwind;
GO

USE DW_Northwind;
GO

--- Dimensiones (Dim_Tables)

CREATE TABLE Dim_Customer (
    CustomerID nchar(5) PRIMARY KEY,
    CompanyName nvarchar(40),
    City nvarchar(15),
    Country nvarchar(15)
);

---

CREATE TABLE Dim_Product (
    ProductID INT PRIMARY KEY,
    ProductName nvarchar(40),
    CategoryName nvarchar(15)
);

---

CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month INT,
    Day INT
);

---

CREATE TABLE Dim_Shipper (
    ShipperID INT PRIMARY KEY,
    CompanyName nvarchar(40)
);

---

CREATE TABLE Dim_Employee (
    EmployeeID INT PRIMARY KEY,
    FullName nvarchar(60)
);

--- Fact Table (Tabla Hechos)

CREATE TABLE Fact_Sales (
    OrderID INT,
    ProductID INT,
    CustomerID nchar(5),
    EmployeeID INT,
    ShipperID INT,
    DateKey INT,

    Quantity SMALLINT,
    UnitPrice MONEY,
    Discount REAL,

    Total AS (Quantity * UnitPrice * (1 - Discount)),

    --- RELACIONES (FOREIGN KEYS)

    CONSTRAINT FK_Fact_Product FOREIGN KEY (ProductID)
        REFERENCES Dim_Product(ProductID),

    CONSTRAINT FK_Fact_Customer FOREIGN KEY (CustomerID)
        REFERENCES Dim_Customer(CustomerID),

    CONSTRAINT FK_Fact_Employee FOREIGN KEY (EmployeeID)
        REFERENCES Dim_Employee(EmployeeID),

    CONSTRAINT FK_Fact_Shipper FOREIGN KEY (ShipperID)
        REFERENCES Dim_Shipper(ShipperID),

    CONSTRAINT FK_Fact_Date FOREIGN KEY (DateKey)
        REFERENCES Dim_Date(DateKey)
);