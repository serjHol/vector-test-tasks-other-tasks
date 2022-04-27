CREATE TABLE Suppliers (
    SupplierID bigserial primary key not null,
    SupplierName varchar(255),
    City varchar(255),
    Country varchar(255)
);
CREATE TABLE Categories (
    CategoryID bigserial primary key not null,
    CategoryName varchar(255),
    Description varchar(255)
);
CREATE TABLE Products (
    ProductID bigserial primary key not null,
    ProductName varchar(255),
    SupplierID bigint references Suppliers (SupplierID),
    CategoryID bigint references Categories (CategoryID),
    Price real
);

INSERT INTO Suppliers (SupplierName, City, Country) values
    ('Exotic Liquid', 'London', 'UK'),
    ('New Orleans Cajun Delights', 'New Orleans', 'USA'),
    ('Grandma Kelly''s Homestead', 'Ann Arbor', 'USA'),
    ('Tokyo Traders', 'Tokyo', 'Japan'),
    ('Cooperativa de Quesos ''Las Cabras''', 'Oviedo', 'Spain');

INSERT INTO Categories (CategoryName, Description) values 
    ('Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
    ('Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
    ('Confections', 'Desserts, candies, and sweet breads'),
    ('Dairy Products', 'Cheeses'),
    ('Grains/Cereals', 'Breads, crackers, pasta, and cereal');

INSERT INTO Products (ProductName, SupplierID, CategoryID, Price) values 
    ('Chais', 1, 1, 18.00),
    ('Chang', 1, 1, 19.00),
    ('Aniseed Syrup', 1, 2, 10.00),
    ('Chef Anton''s Cajun Seasoning', 2, 2, 22.00),
    ('Chef Anton''s Gumbo Mix', 2, 2, 21.35);
--Starts with 'C'

SELECT * FROM Products WHERE ProductName LIKE 'C%';

--ProductName of Product with the lowest price

SELECT ProductName FROM Products WHERE Price = (SELECT MIN(Price) as MinPrice FROM Products);

--Sum of all Products from USA

SELECT SUM(Price) as SumOfPricesFromUSA FROM Products WHERE
SupplierID in (SELECT SupplierID FROM Suppliers WHERE Country = 'USA');

--Suppliers that supply Condiments

SELECT * FROM Suppliers WHERE SupplierID in (
    SELECT DISTINCT SupplierID FROM Products WHERE CategoryID in (
        SELECT CategoryID FROM Categories WHERE CategoryName = 'Condiments'
    )
);

--Select suplier with highest sum of prices of their products

SELECT * FROM (SELECT Suppliers.SupplierName, SUM(Products.Price) as sumValue FROM Products
    LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
    GROUP BY SupplierName) AS Sums WHERE sumValue = (SELECT MAX(sumValue) FROM (
        SELECT Suppliers.SupplierName, SUM(Products.Price) assumValue FROM Products
        LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
    GROUP BY SupplierName) AS Sums);

--Add new Supplier

INSERT INTO Suppliers (SupplierName, City, Country) values ('Norske Meierier', 'Lviv', 'Ukraine');

INSERT INTO Products (ProductName, SupplierID, CategoryID, Price) values (
    'Green tea', (SELECT SupplierID FROM Suppliers WHERE SupplierName='Norske Meierier'),
    (SELECT CategoryID FROM Categories WHERE CategoryName='Beverages'),
    10
);