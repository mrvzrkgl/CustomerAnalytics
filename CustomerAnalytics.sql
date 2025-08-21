
-- DATABASE OLUSTURMA

CREATE DATABASE CustomerAnalytics;
GO

USE CustomerAnalytics;
GO


-- 1. Customers Tablosu
-- M��teri bilgilerini tutar:
-- CustomerID  : Birincil anahtar (otomatik artan ID)
-- FirstName   : M��teri ad�
-- LastName    : M��teri soyad�
-- Gender      : Cinsiyet
-- BirthDate   : Do�um tarihi
-- City        : Ya�ad��� �ehir
-- JoinDate    : Sisteme kat�l�m tarihi

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
-- �r�n bilgilerini tutar:
-- ProductID   : Birincil anahtar (otomatik artan ID)
-- ProductName : �r�n ad�
-- Category    : �r�n kategorisi
-- Price       : �r�n fiyat�

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);


-- 3. Orders Tablosu
-- Sipari� bilgilerini tutar:
-- OrderID     : Birincil anahtar (otomatik artan ID)
-- CustomerID  : Sipari�i veren m��teri (FK -> Customers)
-- OrderDate   : Sipari� tarihi
-- PaymentMethod : �deme y�ntemi

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    PaymentMethod VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- 4. OrderDetails Tablosu
-- Sipari� detaylar�n� tutar:
-- OrderDetailID : Birincil anahtar (otomatik artan ID)
-- OrderID       : �lgili sipari� (FK -> Orders)
-- ProductID     : Sipari�teki �r�n (FK -> Products)
-- Quantity      : Sipari� edilen miktar
-- TotalPrice    : Sat�r toplam fiyat�

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
-- CampaignName : Kampanya ad�
-- StartDate    : Kampanya ba�lang�� tarihi
-- EndDate      : Kampanya biti� tarihi
-- DiscountRate : �ndirim oran� (%)

CREATE TABLE Campaigns (
    CampaignID INT PRIMARY KEY IDENTITY(1,1),
    CampaignName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DiscountRate DECIMAL(5,2)
);


-- 6. CustomerCampaigns Tablosu
-- M��terilerin kampanyalara tepkisini tutar:
-- CustomerID : M��teri (FK -> Customers)
-- CampaignID : Kampanya (FK -> Campaigns)
-- Response   : Kat�l�m durumu (Yes/No/Maybe vb.)
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

-- CUSTOMERS (10 m��teri)

INSERT INTO Customers (FirstName, LastName, Gender, BirthDate, City, JoinDate) VALUES
('Ahmet', 'Y�lmaz', 'Male', '1990-05-14', '�stanbul', '2023-01-15'),
('Ay�e', 'Demir', 'Female', '1995-07-22', 'Ankara', '2023-02-10'),
('Mehmet', 'Kara', 'Male', '1988-03-03', '�zmir', '2023-03-05'),
('Elif', '�elik', 'Female', '1992-09-18', 'Bursa', '2023-04-01'),
('Can', '�ahin', 'Male', '1998-11-10', 'Antalya', '2023-05-20'),
('Zeynep', 'Ayd�n', 'Female', '1993-08-05', 'Adana', '2023-06-12'),
('Burak', 'G�ne�', 'Male', '1985-02-25', 'Eski�ehir', '2023-07-03'),
('Melis', 'Ta�', 'Female', '2000-12-15', 'Gaziantep', '2023-08-09'),
('Emre', 'Polat', 'Male', '1991-04-19', 'Trabzon', '2023-09-18'),
('Selin', 'Ko�', 'Female', '1996-01-23', 'Konya', '2023-10-02');


-- PRODUCTS (10 �r�n)

INSERT INTO Products (ProductName, Category, Price) VALUES
('Laptop', 'Elektronik', 15000.00),
('Kulakl�k', 'Elektronik', 750.00),
('Kahve Makinesi', 'Ev Aletleri', 1200.00),
('Ti��rt', 'Giyim', 250.00),
('Kitap - Veri Analizi', 'Kitap', 180.00),
('Ak�ll� Telefon', 'Elektronik', 20000.00),
('Mikrodalga', 'Ev Aletleri', 3000.00),
('Mont', 'Giyim', 1200.00),
('Roman Kitap', 'Kitap', 95.00),
('Tablet', 'Elektronik', 9500.00);


-- ORDERS (15 sipari�)

INSERT INTO Orders (CustomerID, OrderDate, PaymentMethod) VALUES
(1, '2023-06-01', 'Kredi Kart�'),
(2, '2023-06-05', 'Nakit'),
(3, '2023-06-07', 'Banka Kart�'),
(1, '2023-06-10', 'Kredi Kart�'),
(4, '2023-06-12', 'Kredi Kart�'),
(5, '2023-06-15', 'Kredi Kart�'),
(6, '2023-06-20', 'Nakit'),
(7, '2023-07-01', 'Kredi Kart�'),
(8, '2023-07-05', 'Banka Kart�'),
(9, '2023-07-07', 'Kredi Kart�'),
(10, '2023-07-10', 'Kredi Kart�'),
(3, '2023-07-15', 'Nakit'),
(5, '2023-07-18', 'Kredi Kart�'),
(6, '2023-07-21', 'Banka Kart�'),
(8, '2023-07-25', 'Kredi Kart�');


-- ORDERDETAILS (25 sipari� detay�)

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
('Yaz �ndirimi', '2023-06-01', '2023-06-30', 15.00),
('Okula D�n��', '2023-09-01', '2023-09-15', 10.00),
('Kara Cuma', '2023-11-25', '2023-11-27', 30.00),
('Y�lba�� F�rsat�', '2023-12-20', '2023-12-31', 20.00),
('Sevgililer G�n�', '2024-02-10', '2024-02-15', 25.00),
('Ramazan �ndirimi', '2024-03-15', '2024-04-15', 18.00);


-- CUSTOMER CAMPAIGNS (20 kay�t)

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

-- 1) M��teri Harcama Analizi
-- Her m��terinin toplam harcamas�n� hesaplay�n ve m��terilerin FirstName ve LastName bilgilerini g�sterin.

SELECT 
    c.FirstName,
    c.LastName,
    SUM(od.TotalPrice) AS ToplamHarcama
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY ToplamHarcama DESC;


-- 2) �r�n Sat�� Performans�
-- Her �r�n�n toplam sat�� adedini ve toplam sat�� tutar�n� hesaplay�n. 
-- �r�n ad� ve kategori bilgilerini de listeleyin. 

SELECT od.ProductID, 
		p.ProductName, 
		p.Category,
	SUM(od.Quantity) AS satis_adedi, 
	SUM(od.TotalPrice) AS toplam_tutar
FROM OrderDetails od
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY od.ProductID, p.ProductName, p.Category
ORDER BY p.Category, toplam_tutar DESC;


-- 3) �ehir Bazl� M��teri Da��l�m�
-- �ehirlere g�re ka� m��terinin bulundu�unu g�sterin. 
-- City ve m��teri say�s�n� raporlay�n.

SELECT City, COUNT(CustomerID) AS musteri_sayisi
FROM Customers
GROUP BY City
ORDER BY musteri_sayisi DESC;


-- 4) En �ok Harcama Yapan M��teriler
-- Toplam harcamas� en y�ksek olan 3 m��teriyi listeleyin. 
-- M��teri ad�, soyad� ve toplam harcama tutar�.

SELECT TOP 3 c.FirstName, 
	c.LastName,
	SUM(od.TotalPrice) AS toplam_harcama
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY c.FirstName, c.LastName
ORDER BY toplam_harcama DESC;


-- 5) Kategori Bazl� Ciro Analizi
-- �r�n kategorileri baz�nda toplam sat�� tutar�n� hesaplay�n. 
-- Category ve toplam ciro bilgisi.

SELECT p.Category,
	SUM(od.Quantity) AS satilan_urun_adedi,
	SUM(od.TotalPrice) AS toplam_ciro
FROM Products p
JOIN OrderDetails od ON od.ProductID = p.ProductID
GROUP BY p.Category;


-- 6) Son Sipari� Analizi
-- Her m��terinin yapt��� en son sipari�in tarihini ve sipari� toplam�n� g�sterin. 
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


-- 7) VIP M��teri Tespiti
-- Kat�ld��� kampanyalarda toplam harcamas� belirli bir tutar�n (10.000 TL) �zerinde olan m��terileri listeleyin. 
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


-- 8) Cross-Sell ve Kategori �e�itlili�i
-- Bir m��terinin birden fazla kategoriden �r�n ald��� durumlar� bulun. 
-- CustomerID, FirstName, LastName, al�nan farkl� kategori say�s�.

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


-- 9) M��teri Harcama Segmentasyonu
-- Her m��terinin toplam harcamas�na g�re onlar� segmentlere ay�r�n:
--   - 'VIP' : Toplam Harcama >= 15000
--   - 'Orta Seviye' : 5000 <= Toplam Harcama < 15000
--   - 'D���k' : Toplam Harcama < 5000
-- CustomerID, FirstName, LastName, ToplamHarcama, Segment

SELECT c.CustomerID,
	c.FirstName,
	c.LastName,
	SUM(od.TotalPrice) AS toplam_harcama,
	CASE
		WHEN SUM(od.TotalPrice) > 15000 THEN 'VIP'
		WHEN SUM(od.TotalPrice) > 5000 AND SUM(od.TotalPrice) <= 15000 THEN 'Orta Seviye'
		ELSE 'D���k Seviye'
	END AS harcama_segmenti
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


