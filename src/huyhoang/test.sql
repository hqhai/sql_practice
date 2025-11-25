USE Exc1

-- Bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);

-- Bảng Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500)
);

-- Bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(4,2) DEFAULT 0,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert dữ liệu mẫu
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone, City, Country) VALUES
(1, 'Nguyen Van A', 'a@email.com', '0901234567', 'Hanoi', 'Vietnam'),
(2, 'Tran Thi B', 'b@email.com', '0902234567', 'Ho Chi Minh', 'Vietnam'),
(3, 'Le Van C', 'c@email.com', '0903234567', 'Da Nang', 'Vietnam'),
(4, 'Pham Thi D', 'd@email.com', '0904234567', 'Hanoi', 'Vietnam'),
(5, 'Hoang Van E', 'e@email.com', '0905234567', 'Ho Chi Minh', 'Vietnam');

INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Electronic devices'),
('Clothing', 'Clothes and fashion'),
('Books', 'Books and magazines'),
('Food', 'Food and beverages');

INSERT INTO Products (ProductName, CategoryID, Price, Stock) VALUES
('Laptop Dell', 1, 15000000, 10),
('iPhone 14', 1, 20000000, 5),
('T-Shirt', 2, 150000, 100),
('Jeans', 2, 300000, 50),
('SQL Book', 3, 200000, 30),
('Coffee', 4, 50000, 200);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, '2024-01-15', 15000000, 'Completed'),
(2, '2024-01-20', 350000, 'Completed'),
(1, '2024-02-10', 20000000, 'Pending'),
(3, '2024-02-15', 500000, 'Completed'),
(4, '2024-03-01', 250000, 'Completed');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Discount) VALUES
(1, 1, 1, 15000000, 0),
(2, 3, 1, 150000, 0),
(2, 4, 1, 300000, 0.1),
(3, 2, 1, 20000000, 0),
(4, 5, 2, 200000, 0),
(5, 6, 5, 50000, 0);


-- Ex1
SELECT * FROM Customers;

-- Ex2
SELECT ProductName, Price
FROM Products;

-- Ex3
SELECT CustomerName
FROM Customers
WHERE City = 'Hanoi';

-- Ex4
SELECT ProductName
FROM Products
WHERE Price > 100000;

-- Ex5
SELECT * FROM Orders
WHERE Status = 'Completed';

-- Ex6
SELECT * FROM Products
ORDER BY Price ASC;

-- Ex7
SELECT TOP 5 * FROM Products
ORDER BY Price DESC;

-- Ex8
SELECT * FROM Customers
WHERE CustomerName LIKE 'N%';

-- Ex9
SELECT ProductName
FROM Products
WHERE Stock < 20;

-- Ex10
SELECT DISTINCT City
FROM Customers;

-- Ex11
SELECT * FROM Orders
WHERE Year(OrderDate) = 2024 AND Month(OrderDate) = 1;

-- Ex12
SELECT ProductName, Price
FROM Products
WHERE Price BETWEEN 100000 and 500000;

-- Ex13
SELECT * FROM Customers
ORDER BY CustomerName;

-- Ex14
SELECT * FROM Orders
WHERE TotalAmount > 100000;

-- Ex15
SELECT TOP 10 * FROM Orders
ORDER BY OrderDate DESC;

-- Ex16
SELECT * FROM Products
WHERE CategoryID IN (1, 2, 3);

-- Ex17
SELECT CustomerName, City
FROM Customers
Where City IN ('Hanoi', 'Ho Chi Minh');

-- Ex18
SELECT * FROM Products
WHERE ProductName LIKE '%iPhone%';

-- Ex19
SELECT * FROM Orders
ORDER BY OrderDate DESC, TotalAmount;   

-- Ex20
SELECT TOP 3 * FROM Customers
ORDER BY CustomerName;

-- Ex21
SELECT COUNT(CustomerName)
FROM Customers;

-- Ex22
SELECT SUM(TotalAmount)
FROM Orders;

-- Ex23
SELECT MIN(Price), MAX(Price)
FROM Products;

-- Ex24
SELECT AVG(Price), ProductName
FROM Products
GROUP BY ProductName;

-- Ex25
SELECT CategoryID AS 'ID', COUNT(CategoryID)
FROM Products
GROUP BY CategoryID;

-- Ex26
SELECT MONTH(OrderDate) AS 'Month', SUM(TotalAmount)
FROM Orders
GROUP BY MONTH(OrderDate);

-- Ex27
SELECT CustomerID ,COUNT(*)
FROM Orders
GROUP BY CustomerID;

-- Ex28
SELECT TOP 1 CategoryID, COUNT(*)
FROM Products
GROUP BY CategoryID
ORDER BY COUNT(CategoryID) DESC;

-- Ex29
SELECT ProductID, SUM(UnitPrice)
FROM OrderDetails
GROUP BY ProductID;

-- Ex30
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(City) > 1;

-- Ex31
SELECT CustomerID, SUM(TotalAmount)
FROM Orders
GROUP BY CustomerID;

-- Ex32
SELECT CustomerID, SUM(TotalAmount)
FROM Orders
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 500000;

-- Ex33
SELECT ProductID, Quantity*UnitPrice
FROM OrderDetails;

-- Ex34
SELECT TOP 1 MONTH(OrderDate) AS Month, SUM(TotalAmount)
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY SUM(TotalAmount) DESC;

-- Ex35
SELECT Status, COUNT(Status)
FROM Orders
GROUP BY Status;

-- Ex36
SELECT CategoryID, AVG(Price) AS 'Average Price'
FROM Products
GROUP BY CategoryID;

-- Ex37
SELECT CategoryID, SUM(Stock) AS 'Total stock'
FROM Products
GROUP BY CategoryID
HAVING SUM(Stock) > 100;

-- Ex38
SELECT City, COUNT(City) AS 'Customer count'
FROM Customers
GROUP BY City
ORDER BY COUNT(City) DESC;

-- Ex39
SELECT OrderID, Quantity*UnitPrice*Discount AS 'Discount price'
FROM OrderDetails;

-- Ex40
SELECT ProductID, SUM(Quantity)
FROM OrderDetails
GROUP BY ProductID
HAVING Sum(Quantity) > 5;

-- Ex41
SELECT Customers.CustomerID, CustomerName
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Ex42
SELECT OrderDetails.*, Products.ProductName
FROM OrderDetails
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- Ex43
SELECT Products.*, Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

-- Ex44
SELECT Customers.*, COUNT(Orders.CustomerID) AS 'TotalOrder'
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName, Customers.Email, Customers.Phone, Customers.City, Customers.Country
ORDER BY Customers.CustomerID;

-- Ex45
SELECT Customers.*
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

-- Ex46
SELECT Products.*, SUM(OrderDetails.Quantity) AS 'SaleQuantity'
FROM Products
LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductID, Products.ProductName, Products.CategoryID, Products.Price, Products.Stock
ORDER BY Products.ProductID;

-- Ex47
SELECT Products.*
FROM Products
LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.ProductID IS NULL;

-- Ex48
SELECT Orders.*, Customers.CustomerName, Products.ProductName, OrderDetails.Quantity
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID
LEFT JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- Ex49
SELECT Categories.*, OrderDetails.Quantity, SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS 'TotalSale'
FROM Categories
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Categories.CategoryID, Categories.CategoryName, Categories.Description, OrderDetails.Quantity
ORDER BY Categories.CategoryID;

-- Ex50
SELECT Customers.CustomerName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName IN ('Electronics')

-- Ex51
SELECT Customers.CustomerName, SUM(OrderDetails.Quantity) AS 'TotalItem'
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerName, Customers.CustomerID
ORDER BY Customers.CustomerID;

-- Ex52
SELECT TOP 1 Categories.CategoryName, SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS 'TotalSale'
FROM Categories
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Categories.CategoryName
ORDER BY SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) DESC;

-- Ex53 Fail
SELECT Categories.CategoryName, Products.ProductName, SUM(OrderDetails.Quantity)
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName, Categories.CategoryName
ORDER BY Categories.CategoryName;

-- Ex54
SELECT TOP 1 Customers.CustomerName, COUNT(DISTINCT Categories.CategoryID)
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY CustomerName
ORDER BY COUNT(DISTINCT Categories.CategoryID) DESC;

-- Ex55
SELECT Customers.City, SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS 'TotalSale'
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.City
ORDER BY Customers.City;

-- Ex56
SELECT TOP 1 Products.ProductName, COUNT(DISTINCT Orders.CustomerID)
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Products.ProductName
ORDER BY COUNT(DISTINCT Orders.CustomerID) DESC;

-- Ex57
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;

-- Ex58
SELECT A.ProductName AS ProductName1, B.ProductName AS ProductName2, A.Price
FROM Products A, Products B
WHERE A.ProductName <> B.ProductName
AND A.Price = B.Price
ORDER BY A.Price;

-- Ex59
SELECT OrderDetails.*, Customers.*
FROM OrderDetails
LEFT JOIN Customers ON OrderDetails.ProductID = Customers.CustomerID
WHERE OrderDetails.Discount > 0;

-- Ex61
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- Ex62

-- Ex63
SELECT OD.OrderID, (OD.Quantity * OD.UnitPrice)
FROM OrderDetails OD
WHERE (OD.Quantity * OD.UnitPrice) = (SELECT MAX(Quantity * UnitPrice) FROM OrderDetails);

-- Ex64
SELECT CT.CategoryName, P.ProductName, P.Price
FROM Products P
JOIN Categories CT On P.CategoryID = CT.CategoryID
INNER JOIN (SELECT CategoryID, MAX(Price) AS MaxPrice FROM Products GROUP BY CategoryID)
AS MaxPrices ON P.CategoryID = MaxPrices.CategoryID AND P.Price = MaxPrices.MaxPrice
ORDER BY CT.CategoryName;

-- Ex65
SELECT TOP 1 C.CustomerName, COUNT(OrderID) AS OrderCount
FROM Customers C
JOIN Orders ON C.CustomerID = Orders.CustomerID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY OrderCount DESC;

-- Ex66
SELECT P.ProductName, P.Price, CT.CategoryName
FROM Products P
JOIN Categories CT ON P.CategoryID = CT.CategoryID
WHERE P.Price > ALL (SELECT P2.Price FROM Products P2 JOIN Categories CT2 ON P2.CategoryID = CT2.CategoryID
WHERE CT2.CategoryName = 'Food');

-- Ex67
SELECT TOP 1 CT.CategoryName, AVG(P.Price)
FROM Categories CT
JOIN Products P ON CT.CategoryID = P.CategoryID
GROUP BY CategoryName
ORDER BY AVG(P.Price) DESC;

-- Ex68
SELECT C.CustomerName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories CT ON P.CategoryID = CT.CategoryID
WHERE CT.CategoryName = 'Electronics'
GROUP BY CustomerName
HAVING COUNT(DISTINCT P.ProductID) = (SELECT COUNT(ProductID) FROM Products P2 JOIN Categories CT2 ON P2.CategoryID = CT2.CategoryID
WHERE CT2.CategoryName = 'Electronics');

-- Ex70
SELECT P.ProductName, P.Stock
FROM Products P
WHERE P.Stock < (SELECT AVG(Stock) FROM Products);

-- Ex72
SELECT C.CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories CT ON P.CategoryID = CT.CategoryID
GROUP BY C.CustomerName
HAVING COUNT(DISTINCT CT.CategoryID) = 1;

-- Ex73
SELECT CT.CategoryName
FROM Categories CT
LEFT JOIN Products P ON CT.CategoryID = P.CategoryID
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.OrderDetailID = NULL
GROUP BY CT.CategoryName;

-- Ex74
SELECT TOP 1 ProductName, Price, ABS(Price - (SELECT AVG(PRICE) FROM Products)) AS AvgPriceDiff
FROM Products
ORDER BY AvgPriceDiff ASC;

-- Ex75
SELECT TOP 1 C.CustomerName, O.OrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = '2024'
ORDER BY O.OrderDate ASC;

-- Ex76
