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
INSERT INTO Customers (CustomerName, Email, Phone, City, Country) VALUES
('Nguyen Van A', 'a@email.com', '0901234567', 'Hanoi', 'Vietnam'),
('Tran Thi B', 'b@email.com', '0902234567', 'Ho Chi Minh', 'Vietnam'),
('Le Van C', 'c@email.com', '0903234567', 'Da Nang', 'Vietnam'),
('Pham Thi D', 'd@email.com', '0904234567', 'Hanoi', 'Vietnam'),
('Hoang Van E', 'e@email.com', '0905234567', 'Ho Chi Minh', 'Vietnam');

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
SELECT top 5 * FROM Products
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


