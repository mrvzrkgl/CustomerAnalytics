
-- DATABASE OLUSTURMA

CREATE DATABASE CustomerAnalytics;
GO

USE CustomerAnalytics;
GO


-- 1. Customers Tablosu
-- Müþteri bilgilerini tutar:
-- CustomerID  : Birincil anahtar (otomatik artan ID)
-- FirstName   : Müþteri adý
-- LastName    : Müþteri soyadý
-- Gender      : Cinsiyet
-- BirthDate   : Doðum tarihi
-- City        : Yaþadýðý þehir
-- JoinDate    : Sisteme katýlým tarihi

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    City VARCHAR(50),
    JoinDate DATE
);


-- 2. Products Tablosu
-- Ürün bilgilerini tutar:
-- ProductID   : Birincil anahtar (otomatik artan ID)
-- ProductName : Ürün adý
-- Category    : Ürün kategorisi
-- Price       : Ürün fiyatý

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);


-- 3. Orders Tablosu
-- Sipariþ bilgilerini tutar:
-- OrderID     : Birincil anahtar (otomatik artan ID)
-- CustomerID  : Sipariþi veren müþteri (FK -> Customers)
-- OrderDate   : Sipariþ tarihi
-- PaymentMethod : Ödeme yöntemi

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    PaymentMethod VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- 4. OrderDetails Tablosu
-- Sipariþ detaylarýný tutar:
-- OrderDetailID : Birincil anahtar (otomatik artan ID)
-- OrderID       : Ýlgili sipariþ (FK -> Orders)
-- ProductID     : Sipariþteki ürün (FK -> Products)
-- Quantity      : Sipariþ edilen miktar
-- TotalPrice    : Satýr toplam fiyatý

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- 5. Campaigns Tablosu
-- Kampanya bilgilerini tutar:
-- CampaignID   : Birincil anahtar (otomatik artan ID)
-- CampaignName : Kampanya adý
-- StartDate    : Kampanya baþlangýç tarihi
-- EndDate      : Kampanya bitiþ tarihi
-- DiscountRate : Ýndirim oraný (%)

CREATE TABLE Campaigns (
    CampaignID INT PRIMARY KEY IDENTITY(1,1),
    CampaignName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DiscountRate DECIMAL(5,2)
);


-- 6. CustomerCampaigns Tablosu
-- Müþterilerin kampanyalara tepkisini tutar:
-- CustomerID : Müþteri (FK -> Customers)
-- CampaignID : Kampanya (FK -> Campaigns)
-- Response   : Katýlým durumu (Yes/No/Maybe vb.)
-- PRIMARY KEY (CustomerID, CampaignID) -> Composite Key

CREATE TABLE CustomerCampaigns (
    CustomerID INT,
    CampaignID INT,
    Response VARCHAR(20),
    PRIMARY KEY (CustomerID, CampaignID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID)
);


-- DATA EKLEME

-- CUSTOMERS (10 müþteri)

INSERT INTO Customers (FirstName, LastName, Gender, BirthDate, City, JoinDate) VALUES
('Ahmet', 'Yýlmaz', 'Male', '1990-05-14', 'Ýstanbul', '2023-01-15'),
('Ayþe', 'Demir', 'Female', '1995-07-22', 'Ankara', '2023-02-10'),
('Mehmet', 'Kara', 'Male', '1988-03-03', 'Ýzmir', '2023-03-05'),
('Elif', 'Çelik', 'Female', '1992-09-18', 'Bursa', '2023-04-01'),
('Can', 'Þahin', 'Male', '1998-11-10', 'Antalya', '2023-05-20'),
('Zeynep', 'Aydýn', 'Female', '1993-08-05', 'Adana', '2023-06-12'),
('Burak', 'Güneþ', 'Male', '1985-02-25', 'Eskiþehir', '2023-07-03'),
('Melis', 'Taþ', 'Female', '2000-12-15', 'Gaziantep', '2023-08-09'),
('Emre', 'Polat', 'Male', '1991-04-19', 'Trabzon', '2023-09-18'),
('Selin', 'Koç', 'Female', '1996-01-23', 'Konya', '2023-10-02');


-- PRODUCTS (10 ürün)

INSERT INTO Products (ProductName, Category, Price) VALUES
('Laptop', 'Elektronik', 15000.00),
('Kulaklýk', 'Elektronik', 750.00),
('Kahve Makinesi', 'Ev Aletleri', 1200.00),
('Tiþört', 'Giyim', 250.00),
('Kitap - Veri Analizi', 'Kitap', 180.00),
('Akýllý Telefon', 'Elektronik', 20000.00),
('Mikrodalga', 'Ev Aletleri', 3000.00),
('Mont', 'Giyim', 1200.00),
('Roman Kitap', 'Kitap', 95.00),
('Tablet', 'Elektronik', 9500.00);


-- ORDERS (15 sipariþ)

INSERT INTO Orders (CustomerID, OrderDate, PaymentMethod) VALUES
(1, '2023-06-01', 'Kredi Kartý'),
(2, '2023-06-05', 'Nakit'),
(3, '2023-06-07', 'Banka Kartý'),
(1, '2023-06-10', 'Kredi Kartý'),
(4, '2023-06-12', 'Kredi Kartý'),
(5, '2023-06-15', 'Kredi Kartý'),
(6, '2023-06-20', 'Nakit'),
(7, '2023-07-01', 'Kredi Kartý'),
(8, '2023-07-05', 'Banka Kartý'),
(9, '2023-07-07', 'Kredi Kartý'),
(10, '2023-07-10', 'Kredi Kartý'),
(3, '2023-07-15', 'Nakit'),
(5, '2023-07-18', 'Kredi Kartý'),
(6, '2023-07-21', 'Banka Kartý'),
(8, '2023-07-25', 'Kredi Kartý');


-- ORDERDETAILS (25 sipariþ detayý)

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, TotalPrice) VALUES
(1, 1, 1, 15000.00), 
(1, 2, 1, 750.00), 
(2, 4, 2, 500.00),
(3, 3, 1, 1200.00),
(4, 5, 1, 180.00),
(5, 4, 3, 750.00),
(6, 6, 1, 20000.00),
(7, 7, 1, 3000.00),
(8, 2, 2, 1500.00),
(9, 8, 1, 1200.00),
(10, 9, 4, 380.00),
(11, 10, 1, 9500.00),
(12, 1, 1, 15000.00),
(12, 3, 1, 1200.00),
(13, 2, 3, 2250.00),
(13, 5, 2, 360.00),
(14, 6, 1, 20000.00),
(14, 4, 2, 500.00),
(15, 8, 2, 2400.00),
(15, 9, 1, 95.00),
(7, 5, 1, 180.00),
(9, 3, 1, 1200.00),
(10, 2, 1, 750.00),
(11, 4, 2, 500.00),
(6, 9, 2, 190.00);


-- CAMPAIGNS (6 kampanya)

INSERT INTO Campaigns (CampaignName, StartDate, EndDate, DiscountRate) VALUES
('Yaz Ýndirimi', '2023-06-01', '2023-06-30', 15.00),
('Okula Dönüþ', '2023-09-01', '2023-09-15', 10.00),
('Kara Cuma', '2023-11-25', '2023-11-27', 30.00),
('Yýlbaþý Fýrsatý', '2023-12-20', '2023-12-31', 20.00),
('Sevgililer Günü', '2024-02-10', '2024-02-15', 25.00),
('Ramazan Ýndirimi', '2024-03-15', '2024-04-15', 18.00);


-- CUSTOMER CAMPAIGNS (20 kayýt)

INSERT INTO CustomerCampaigns (CustomerID, CampaignID, Response) VALUES
(1, 1, 'Yes'),
(2, 1, 'No'),
(3, 2, 'Yes'),
(4, 3, 'Maybe'),
(5, 4, 'Yes'),
(6, 5, 'Yes'),
(7, 2, 'No'),
(8, 3, 'Yes'),
(9, 6, 'Yes'),
(10, 1, 'No'),
(1, 3, 'Yes'),
(2, 4, 'Yes'),
(3, 5, 'No'),
(4, 6, 'Yes'),
(5, 2, 'Maybe'),
(6, 1, 'Yes'),
(7, 4, 'Yes'),
(8, 5, 'No'),
(9, 2, 'Yes'),
(10, 6, 'Maybe');



------------ CASE ------------

-- 1) Müþteri Harcama Analizi
-- Her müþterinin toplam harcamasýný hesaplayýn ve müþterilerin FirstName ve LastName bilgilerini gösterin.

SELECT 
    c.FirstName,
    c.LastName,
    SUM(od.TotalPrice) AS ToplamHarcama
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY ToplamHarcama DESC;


-- 2) Ürün Satýþ Performansý
-- Her ürünün toplam satýþ adedini ve toplam satýþ tutarýný hesaplayýn. 
-- Ürün adý ve kategori bilgilerini de listeleyin. 

SELECT od.ProductID, 
		p.ProductName, 
		p.Category,
	SUM(od.Quantity) AS satis_adedi, 
	SUM(od.TotalPrice) AS toplam_tutar
FROM OrderDetails od
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY od.ProductID, p.ProductName, p.Category
ORDER BY p.Category, toplam_tutar DESC;


-- 3) Þehir Bazlý Müþteri Daðýlýmý
-- Þehirlere göre kaç müþterinin bulunduðunu gösterin. 
-- City ve müþteri sayýsýný raporlayýn.

SELECT City, COUNT(CustomerID) AS musteri_sayisi
FROM Customers
GROUP BY City
ORDER BY musteri_sayisi DESC;


-- 4) En Çok Harcama Yapan Müþteriler
-- Toplam harcamasý en yüksek olan 3 müþteriyi listeleyin. 
-- Müþteri adý, soyadý ve toplam harcama tutarý.

SELECT TOP 3 c.FirstName, 
	c.LastName,
	SUM(od.TotalPrice) AS toplam_harcama
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY c.FirstName, c.LastName
ORDER BY toplam_harcama DESC;


-- 5) Kategori Bazlý Ciro Analizi
-- Ürün kategorileri bazýnda toplam satýþ tutarýný hesaplayýn. 
-- Category ve toplam ciro bilgisi.

SELECT p.Category,
	SUM(od.Quantity) AS satilan_urun_adedi,
	SUM(od.TotalPrice) AS toplam_ciro
FROM Products p
JOIN OrderDetails od ON od.ProductID = p.ProductID
GROUP BY p.Category;


-- 6) Son Sipariþ Analizi
-- Her müþterinin yaptýðý en son sipariþin tarihini ve sipariþ toplamýný gösterin. 
-- CustomerID, FirstName, LastName, LastOrderDate, LastOrderTotal.


WITH LastOrders AS (
    SELECT 
        o.CustomerID,
        MAX(o.OrderDate) AS LastOrderDate
    FROM Orders o
    GROUP BY o.CustomerID
)
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    lo.LastOrderDate,
    SUM(od.TotalPrice) AS LastOrderTotal
FROM LastOrders lo
JOIN Customers c ON c.CustomerID = lo.CustomerID
JOIN Orders o ON o.CustomerID = c.CustomerID AND o.OrderDate = lo.LastOrderDate
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName, lo.LastOrderDate
ORDER BY lo.LastOrderDate DESC;


-- 7) VIP Müþteri Tespiti
-- Katýldýðý kampanyalarda toplam harcamasý belirli bir tutarýn (10.000 TL) üzerinde olan müþterileri listeleyin. 
-- CustomerID, FirstName, LastName, ToplamHarcama.

SELECT cc.CustomerID,
	c.FirstName, c.LastName,
	COUNT(DISTINCT cc.CampaignID) AS kampanya_katilma_sayisi,
	SUM(od.TotalPrice) AS toplam_Harcama
FROM CustomerCampaigns cc
JOIN Customers c ON c.CustomerID = cc.CustomerID
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY cc.CustomerID, c.FirstName, c.LastName
HAVING SUM(od.TotalPrice) > 10000
ORDER BY SUM(od.TotalPrice) DESC;


-- 8) Cross-Sell ve Kategori Çeþitliliði
-- Bir müþterinin birden fazla kategoriden ürün aldýðý durumlarý bulun. 
-- CustomerID, FirstName, LastName, alýnan farklý kategori sayýsý.

SELECT c.CustomerID,
	c.FirstName,
	c.LastName,
	COUNT(DISTINCT p.Category) AS kategori_sayisi
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(DISTINCT p.Category) > 1
ORDER BY kategori_sayisi DESC;


-- 9) Müþteri Harcama Segmentasyonu
-- Her müþterinin toplam harcamasýna göre onlarý segmentlere ayýrýn:
--   - 'VIP' : Toplam Harcama >= 15000
--   - 'Orta Seviye' : 5000 <= Toplam Harcama < 15000
--   - 'Düþük' : Toplam Harcama < 5000
-- CustomerID, FirstName, LastName, ToplamHarcama, Segment

SELECT c.CustomerID,
	c.FirstName,
	c.LastName,
	SUM(od.TotalPrice) AS toplam_harcama,
	CASE
		WHEN SUM(od.TotalPrice) > 15000 THEN 'VIP'
		WHEN SUM(od.TotalPrice) > 5000 AND SUM(od.TotalPrice) <= 15000 THEN 'Orta Seviye'
		ELSE 'Düþük Seviye'
	END AS harcama_segmenti
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


