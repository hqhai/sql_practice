USE Lanh;
DROP TABLE Products;
DROP TABLE Categories;
DROP TABLE customers;
DROP TABLE Orders;
DROP TABLE OrderDetails;
go
create table customers (
CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

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
INSERT INTO customers (CustomerName, Email, Phone, City, Country) VALUES
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
---bai 1 - 20
SELECT * FROM customers;

SELECT ProductName, Price 
from Products; 

select City, CustomerName
from customers
where City = 'Hanoi';

select ProductID, ProductName, Price
from Products
where Price > 1000000;

select CustomerID, OrderDate, TotalAmount, status
from Orders
where status = 'Completed';

select ProductName, Price
from Products
ORDER BY Price ASC;

select TOP 5  ProductName, Price 
from Products
ORDER BY Price DESC;

select CustomerID, CustomerName,City
from customers
where CustomerName LIKE 'N%';
 
SELECT * FROM Products
where Stock < 20;

SELECT DISTINCT City
FROM customers;

select * from Orders
where YEAR(OrderDate) = '2024'
AND MONTH(OrderDate) = '01';

SELECT * FROM Products
where Price between 100000 and 500000;

SELECT * FROM customers
ORDER BY CustomerName ASC;

SELECT * FROM Orders
WHERE TotalAmount > 1000000;

SELECT TOP 10 * FROM Orders
ORDER BY OrderDate DESC;

SELECT * FROM Products
WHERE CategoryID IN (1, 2, 3);

SELECT * FROM customers
WHERE City IN ('Hanoi', 'Ho Chi Minh');

SELECT * FROM Products
WHERE ProductName LIKE '%iPhone%';

SELECT * FROM Orders
ORDER BY OrderDate DESC, TotalAmount ASC;

SELECT TOP 3 * FROM customers
ORDER BY CustomerName ASC;
---dang2----
SELECT COUNT(*) FROM customers;

select sum(TotalAmount) AS tongtien
from Orders;

SELECT MAX(Price) AS giacaonhat, MIN(Price) AS giathapnhat
FROM Products;

SELECT AVG(Price) AS giatrungbinh
FROM Products;

SELECT CategoryID, COUNT(ProductID) AS sosptrongcategory
FROM Products
GROUP BY CategoryID;

---26---
SELECT
    MONTH(OrderDate) AS SalesMonth,
    SUM(TotalAmount) AS tongthang
FROM
    Orders
GROUP BY
    MONTH(OrderDate)
ORDER BY
    SalesMonth;
---27---
SELECT CustomerID, COUNT(*) AS soluongdonhang
FROM Orders
GROUP BY CustomerID;
--28-40--
select TOP 1
CategoryID,
COUNT(ProductID) AS spnhieunhat
from Products
GROUP BY
    CategoryID
ORDER BY
    spnhieunhat DESC;


    SELECT
    ProductID,
    SUM(Quantity) AS soluongmoisp
FROM
    OrderDetails
GROUP BY
    ProductID
ORDER BY
    soluongmoisp DESC;

    select 
    City,
    count(CustomerID) AS thanhpho
    from customers
    group by City
    having 
    count(CustomerID) > 1;

   
SELECT
    CustomerID,
    SUM(TotalAmount) AS Tongdonhang
FROM
    Orders
GROUP BY
    CustomerID;

    SELECT
    CustomerID,
    SUM(TotalAmount) AS tonggiatri
FROM
    Orders
GROUP BY
    CustomerID
HAVING
    SUM(TotalAmount) > 5000000;

 SELECT
    P.CategoryID,
    SUM(OD.Quantity * P.Price) AS CategoryRevenue
FROM
    OrderDetails OD,
    Products P
WHERE
    OD.ProductID = P.ProductID
GROUP BY
    P.CategoryID;


    SELECT TOP 1
    FORMAT(OrderDate, 'yyyy-MM') AS SalesMonth,
    SUM(TotalAmount) AS doanhthuthang
FROM
    Orders
GROUP BY
    FORMAT(OrderDate, 'yyyy-MM')
ORDER BY
    doanhthuthang DESC;

SELECT
    Status,
    COUNT(OrderID) AS donhangtheotrangthai
FROM
    Orders
GROUP BY
    Status;

SELECT
    CategoryID,
    AVG(Price) AS giatrungbinh
FROM
    Products
GROUP BY
    CategoryID;

    SELECT
    CategoryID,
    SUM(Stock) AS Tonkho
FROM
    Products
GROUP BY
    CategoryID
HAVING
    SUM(Stock) > 100;

    SELECT
    City,
    COUNT(CustomerID) AS khachhangtaiday
FROM
    Customers
GROUP BY
    City;

   
SELECT
    OrderID,
    SUM(Discount) AS giamgia
FROM
    OrderDetails
GROUP BY
    OrderID;

    SELECT
    ProductID,
    SUM(Quantity) AS tongsolgban
FROM
    OrderDetails
GROUP BY
    ProductID
HAVING
    SUM(Quantity) > 5;

    ---dang3---
    --41--
    select 
    Orders.OrderDate,
    Orders.OrderID,
    customers.CustomerName,
    customers.City
    from
    Orders
    inner join
    customers on Orders.CustomerID = customers.CustomerID;
    --42--
    select
    OrderDetails.OrderID,
    OrderDetails.Quantity,
    OrderDetails.UnitPrice,
    OrderDetails.Discount,
    Products.ProductName
    from
    OrderDetails
    inner join
    Products on OrderDetails.ProductID = Products.ProductID;

    --43--
select
Products.ProductName,
Products.ProductID,
Products.Price,
Categories.CategoryName
from
Products
inner join 
Categories on Products.CategoryID = Categories.CategoryID;
--44--
select
customers.CustomerName AS tenkhachhang,
COUNT(Orders.OrderID) AS soluongdonhang
from
customers
left join 
Orders on customers.CustomerID = Orders.CustomerID
group by
customers.CustomerID, customers.CustomerName
order by
customers.CustomerName;

--45--
select 
customers.CustomerName,
customers.Country,
customers.Phone
from
customers
left join
Orders on customers.CustomerID =  Orders.CustomerID
where
Orders.OrderID is null;

--46--
SELECT
    P.ProductName,
    ISNULL(SUM(OD.Quantity), 0) AS Total
FROM
    Products AS P
LEFT JOIN
    OrderDetails AS OD ON P.ProductID = OD.ProductID
GROUP BY
    P.ProductID, P.ProductName
ORDER BY
    Total DESC;

    --47--
    SELECT
    P.ProductName,
    P.ProductID
FROM
    Products AS P
LEFT JOIN
    OrderDetails ON P.ProductID = OrderDetails.ProductID
WHERE
    OrderDetails.OrderDetailID IS NULL;

    --48--
    SELECT
    Orders.OrderID,
    C.CustomerName,
    P.ProductName,
    OD.Quantity,
    OD.UnitPrice
FROM
    Orders 
INNER JOIN
    Customers AS C ON Orders.CustomerID = C.CustomerID
INNER JOIN
    OrderDetails AS OD ON Orders.OrderID = OD.OrderID
INNER JOIN
    Products AS P ON OD.ProductID = P.ProductID
ORDER BY
    Orders.OrderID;

    --49--
    SELECT
    Categories.CategoryName,
    SUM(OD.Quantity * OD.UnitPrice) AS Tongdoanhthu
FROM
    Categories
INNER JOIN
    Products AS P ON Categories.CategoryID = P.CategoryID
INNER JOIN
    OrderDetails AS OD ON P.ProductID = OD.ProductID
GROUP BY
    Categories.CategoryID, Categories.CategoryName
ORDER BY
    Tongdoanhthu DESC;
 
 --50--
 SELECT DISTINCT
    customers.CustomerName,
    customers.CustomerID
FROM
    customers 
INNER JOIN
    Orders ON customers.CustomerID = Orders.CustomerID
INNER JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN
    Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN
    Categories ON Products.CategoryID = Categories.CategoryID
WHERE
    Categories.CategoryName = 'Electronics';

    --51--
    SELECT
    C.CustomerName,
    ISNULL(SUM(OD.Quantity), 0) AS Tongsanphamdamua
FROM
    Customers AS C
LEFT JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
LEFT JOIN
    OrderDetails AS OD ON O.OrderID = OD.OrderID
GROUP BY
    C.CustomerID, C.CustomerName
ORDER BY
    Tongsanphamdamua DESC;

    --52--

   SELECT TOP 1
    Categories.CategoryName,
    SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS Top1
FROM
    Categories 
INNER JOIN
    Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Categories.CategoryID, Categories.CategoryName
ORDER BY
    Top1  DESC;

    --54--
    SELECT TOP 1
    C.CustomerName,
    COUNT(DISTINCT P.CategoryID) AS khachmuahangkhacnhau
FROM
    Customers AS C
INNER JOIN
    Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN
    OrderDetails AS OD ON O.OrderID = OD.OrderID
INNER JOIN
    Products AS P ON OD.ProductID = P.ProductID
GROUP BY
    C.CustomerID, C.CustomerName
ORDER BY
    khachmuahangkhacnhau DESC;

    --55--
    SELECT
    customers.City,
    ISNULL(SUM(Orders.TotalAmount), 0) AS doanhthutheotp
FROM
    Customers
LEFT JOIN
    Orders ON customers.CustomerID = Orders.CustomerID
GROUP BY
    customers.City
ORDER BY
    doanhthutheotp DESC;
    --56--

    SELECT TOP 1
    Products.ProductName,
    COUNT(DISTINCT O.CustomerID) AS dcmuanhieu
FROM
    Products 
INNER JOIN
    OrderDetails AS OD ON Products.ProductID = OD.ProductID
INNER JOIN
    Orders AS O ON OD.OrderID = O.OrderID
GROUP BY
    Products.ProductID, Products.ProductName
ORDER BY
    dcmuanhieu DESC;

    --57--
    SELECT
    C1.CustomerName AS Customer1,
    C2.CustomerName AS Customer2,
    C1.City AS SharedCity
FROM
    Customers AS C1
INNER JOIN
    Customers AS C2 ON C1.City = C2.City
WHERE
    C1.CustomerID <> C2.CustomerID
    AND C1.CustomerID < C2.CustomerID 
ORDER BY
    SharedCity, Customer1;

    --58--
    select
    p1.ProductName AS sp1,
    p2.ProductName AS sp2,
    p1.Price AS giachung
    from
    Products AS p1
    inner join
    Products AS p2
    on
    p1.Price = p2.Price
    where
    p1.ProductID <> p2.ProductID
    and p1.ProductID < p2.ProductID
    order by
    giachung, sp1;

    --59--
    SELECT DISTINCT
    Orders.OrderID,
    customers.CustomerName,
    Orders.OrderDate,
    OrderDetails.Discount
FROM
    Orders 
INNER JOIN
    Customers ON Orders.CustomerID = customers.CustomerID
INNER JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE
    OrderDetails.Discount > 0;

    --60--

   SELECT
    Products.ProductName,
    AVG(OrderDetails.Discount) AS giamgiatbinh
FROM
    Products 
INNER JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Products.ProductID, Products.ProductName
ORDER BY
    giamgiatbinh DESC;
    --dang4--
    --61--
    select
    ProductName,
    Price
    from
    Products
    WHERE
    Price > (SELECT AVG(Price) FROM Products);

    --63--
    SELECT TOP 1 OrderID, SUM(Quantity * UnitPrice * (1 - Discount)) AS OrderValue
FROM OrderDetails
GROUP BY OrderID
ORDER BY OrderValue DESC;

--65--
SELECT TOP 1 customers.CustomerID, customers.CustomerName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers 
JOIN Orders ON customers.CustomerID = Orders.CustomerID
GROUP BY customers.CustomerID, customers.CustomerName
ORDER BY OrderCount DESC;
--67--
select
C.CategoryName, 
    AVG(P.Price) AS AveragePrice
FROM 
    Products P
JOIN 
    Categories C ON P.CategoryID = C.CategoryID
GROUP BY 
    C.CategoryID, C.CategoryName
HAVING 
    AVG(P.Price) = (
    select max(AvgPrice)
    from(
    select AVG(Price) AS AvgPrice
    from
    Products
    group by CategoryID
    ) AS giatbinhspcaonhat
    );

    --64--
    SELECT 
    P.ProductName, 
    P.Price, 
    C.CategoryName
FROM 
    Products P
INNER JOIN 
    Categories C ON P.CategoryID = C.CategoryID
INNER JOIN 
    (
        SELECT CategoryID, MAX(Price) AS MaxPrice
        FROM Products
        GROUP BY CategoryID
    ) AS MaxPrices ON P.CategoryID = MaxPrices.CategoryID 
                  AND P.Price = MaxPrices.MaxPrice;

