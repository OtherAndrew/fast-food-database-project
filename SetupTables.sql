DROP DATABASE IF EXISTS fast_food;
CREATE DATABASE fast_food;
GO
USE fast_food;

-- 3
DROP TABLE IF EXISTS Address;
CREATE TABLE Address (AddressID SERIAL PRIMARY KEY,
                      StreetAddress VARCHAR(255),
                      City VARCHAR(255),
                      ZIP INT,
                      State VARCHAR(255),
                      Country VARCHAR(255)
);

INSERT INTO 
    Address(StreetAddress, City, ZIP, State, Country)
VALUES
	('9670 Lees Creek Dr.', 'Halethorpe', '21227', 'MD', 'United States'),
	('83 Newport St.', 'Vista', '92083', 'CA', 'United States'),
	('214 Linden Ave.', 'Elizabethton', '37643', 'TN', 'United States'),
	('78 Glenwood Drive', 'Monroeville', '15146', 'PA', 'United States'),
	('12 Mayflower Dr.', 'Stockbridge', '30281', 'GA', 'United States'),
	('8462 Yukon Rd.', 'Poughkeepsie', '12601', 'NY', 'United States'),
	('993 Princeton Ave.','Mason City', '50401', 'IA', 'United States')
;

-- 5
DROP TABLE IF EXISTS StoreBranch;
CREATE TABLE StoreBranch (StoreNumber SERIAL PRIMARY KEY,
                          AddressID BIGINT NOT NULL,
                          Manager VARCHAR(255),
                          FOREIGN KEY(AddressID) REFERENCES Address(AddressID)
);

INSERT INTO 
    StoreBranch(AddressID, Manager)
VALUES
	((SELECT AddressID FROM Address WHERE StreetAddress = '12 Mayflower Dr.'), 'Doctor Han'),
	((SELECT AddressID FROM Address WHERE StreetAddress = '8462 Yukon Rd.'), 'Walter White'),
	((SELECT AddressID FROM Address WHERE StreetAddress = '993 Princeton Ave.'), 'Satori Komeiji')
;

-- 1
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (CustomerID SERIAL PRIMARY KEY,
                        Name VARCHAR(255) NOT NULL,
                        RewardsPoints INT DEFAULT 0
);

INSERT INTO 
    Customers(Name)
VALUES
	('Raymoo Hakuray'),
	('David Hayter'),
	('Gordan Freeman'),
	('Chen')
;

-- 2
DROP TABLE IF EXISTS CustomerAddress;
CREATE TABLE CustomerAddress (CustomerID BIGINT NOT NULL,
                              AddressID BIGINT NOT NULL,
                              FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                              FOREIGN KEY(AddressID) REFERENCES Address(AddressID)
);

INSERT INTO 
    CustomerAddress(CustomerID, AddressID)
VALUES
	((SELECT CustomerID FROM Customers WHERE Name = 'Raymoo Hakuray'),
		(SELECT AddressID FROM Address WHERE StreetAddress = '9670 Lees Creek Dr.')),
	((SELECT CustomerID FROM Customers WHERE Name = 'David Hayter'), 
		(SELECT AddressID FROM Address WHERE StreetAddress = '83 Newport St.')),
	((SELECT CustomerID FROM Customers WHERE Name = 'Gordan Freeman'), 
		(SELECT AddressID FROM Address WHERE StreetAddress = '214 Linden Ave.')),
	((SELECT CustomerID FROM Customers WHERE Name = 'Chen'), 
		(SELECT AddressID FROM Address WHERE StreetAddress = '78 Glenwood Drive'))
;

DROP TABLE IF EXISTS PaymentMethod;
CREATE TABLE PaymentMethod (Method VARCHAR(255) PRIMARY KEY);

INSERT INTO 
    PaymentMethod(Method)
VALUES 
    ('Cash'),
    ('Credit card'),
    ('Gift card'),
    ('Rewards')
;

DROP TABLE IF EXISTS PickupMethod;
CREATE TABLE PickupMethod (Method VARCHAR(255) PRIMARY KEY);

INSERT INTO 
    PickupMethod(Method)
VALUES 
    ('Drive-thru'),
    ('Delivery'),
    ('Walk in'),
    ('Dine in')
;

-- 6
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (OrderNumber SERIAL PRIMARY KEY,
                     StoreNumber BIGINT NOT NULL,
                     CustomerID BIGINT NOT NULL,
                     PickupMethod VARCHAR(255) NOT NULL,
                     PaymentMethod VARCHAR(255) NOT NULL,
                     OrderTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                     FOREIGN KEY(StoreNumber) REFERENCES StoreBranch(StoreNumber),
                     FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                     FOREIGN KEY(PickupMethod) REFERENCES PickupMethod(Method),
                     FOREIGN KEY(PaymentMethod) REFERENCES PaymentMethod(Method)
);

INSERT INTO 
    Orders(StoreNumber, CustomerID, PickupMethod, PaymentMethod)
VALUES
	((SELECT StoreNumber FROM StoreBranch WHERE Manager = 'Doctor Han'), 
		(SELECT CustomerID FROM Customers WHERE Name = 'Raymoo Hakuray'),
		'Walk in', 'Cash'),
	((SELECT StoreNumber FROM StoreBranch WHERE Manager = 'Doctor Han'), 
		(SELECT CustomerID FROM Customers WHERE Name = 'David Hayter'),
		'Drive-thru', 'Credit card'),
	((SELECT StoreNumber FROM StoreBranch WHERE Manager = 'Doctor Han'), 
		(SELECT CustomerID FROM Customers WHERE Name = 'Raymoo Hakuray'),
		'Delivery', 'Rewards'),
	((SELECT StoreNumber FROM StoreBranch WHERE Manager = 'Satori Komeiji'), 
		(SELECT CustomerID FROM Customers WHERE Name = 'Chen'),
		'Dine in', 'Gift card'),
	((SELECT StoreNumber FROM StoreBranch WHERE Manager = 'Walter White'), 
		(SELECT CustomerID FROM Customers WHERE Name = 'Chen'),
		'Dine in', 'Cash'),
	((SELECT StoreNumber FROM StoreBranch WHERE Manager = 'Satori Komeiji'), 
		(SELECT CustomerID FROM Customers WHERE Name = 'Gordan Freeman'),
		'Walk in', 'Credit card')
;

-- 8
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (ItemNumber SERIAL PRIMARY KEY,
                    ItemName VARCHAR(255) UNIQUE,
                    Price DECIMAL(10, 2)
);

INSERT INTO 
    Items(ItemName, Price)
VALUES
    ('Hamburger', 2.99),
    ('Cheeseburger', 3.99),
    ('Double Hamburger', 4.99),
    ('Double Cheeseburger', 5.99),
    ('Small Fries', 1.99),
    ('Large Fries', 2.99),
    ('Onion Rings', 3.99),
    ('Pickle Chips', 3.99),
    ('Small Drink', 0.99),
    ('Medium Drink', 1.99),
    ('Large Drink', 2.99),
    ('Sausage Breakfast Sandwich', 2.99),
    ('Bacon Breakfast Sandwich', 2.99),
    ('Hash Browns', 1.99),
    ('Halloween Burger', 5.99),
    ('Christmas Burger', 5.99),
    ('Hamburger Combo', 8.99),
    ('Cheeseburger Combo', 8.99),
    ('Double Hamburger Combo', 9.99),
    ('Double Cheeseburger Combo', 9.99),
    ('Sausage Breakfast Combo', 7.99),
    ('Bacon Breakfast Combo', 7.99)
;

DROP TABLE IF EXISTS EntreeItems;
CREATE TABLE EntreeItems (ItemNumber BIGINT PRIMARY KEY,
                          FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

INSERT INTO 
    EntreeItems(ItemNumber)
VALUES 
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Hamburger')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Sandwich')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Sandwich')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Halloween Burger')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Christmas Burger'))
;

DROP TABLE IF EXISTS SideItems;
CREATE TABLE SideItems (ItemNumber UNSIGNED PRIMARY KEY
                        FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

INSERT INTO 
    SideItems(ItemNumber)
VALUES 
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Large Fries')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Onion Rings')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Pickle Chips')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'))
;

DROP TABLE IF EXISTS DrinkItems;
CREATE TABLE DrinkItems (ItemNumber UNSIGNED PRIMARY KEY,
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber),
                         FOREIGN KEY(Ice) REFERENCES IceLevel(Level)
);

INSERT INTO 
    DrinkItems(ItemNumber)
VALUES 
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Small Drink')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Large Drink'))
;

DROP TABLE IF EXISTS Seasons;
CREATE TABLE Seasons(Season VARCHAR(255) PRIMARY KEY);

INSERT INTO 
    Seasons(Season)
VALUES 
    ('Winter'),
    ('Spring'),
    ('Summer'),
    ('Fall')
;

DROP TABLE IF EXISTS LimitedItems;
CREATE TABLE LimitedItems (ItemNumber BIGINT PRIMARY KEY,
                           Season VARCHAR(255),
                           FOREIGN KEY(Season) REFERENCES Seasons(Season),
                           FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

INSERT INTO 
    LimitedItems(ItemNumber)
VALUES 
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Halloween Burger')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Christmas Burger'))
;

-- 15
DROP TABLE IF EXISTS BreakfastItems;
CREATE TABLE BreakfastItems (ItemNumber BIGINT PRIMARY KEY,
                             FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

INSERT INTO 
    BreakfastItems(ItemNumber)
VALUES 
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Sandwich')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Sandwich')),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'))
;

DROP TABLE IF EXISTS Combos;
CREATE TABLE Combos (ItemNumber BIGINT PRIMARY KEY,
                     EntreeItemNumber BIGINT NOT NULL,
                     SideItemNumber BIGINT NOT NULL,
                     DrinkItemNumber BIGINT NOT NULL,
                     FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber),
                     FOREIGN KEY(EntreeItemNumber) REFERENCES EntreeItems(ItemNumber),
                     FOREIGN KEY(SideItemNumber) REFERENCES SideItems(ItemNumber),
                     FOREIGN KEY(DrinkItemNumber) REFERENCES DrinkItems(ItemNumber)
);

INSERT INTO 
    Combos(ItemNumber, EntreeItemNumber, SideItemNumber, DrinkItemNumber)
VALUES
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink')
    )
;

DROP TABLE IF EXISTS OrderItems;
CREATE TABLE OrderItems (OrderNumber BIGINT NOT NULL,
                         ItemNumber BIGINT NOT NULL,
                         Quantity INT DEFAULT 1,
                         Modifications VARCHAR(255),
                         FOREIGN KEY(OrderNumber) REFERENCES Orders(OrderNumber),
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

INSERT INTO 
    OrderItems(OrderNumber, ItemNumber, Quantity, Modifications)
VALUES

;

-- 17
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber BIGINT PRIMARY KEY,
                            Calories INT,
                            Vegetarian INT DEFAULT 0,
                            Vegan INT DEFAULT 0
);

INSERT INTO 
    ItemNutrition(ItemNumber, Calories, Vegetarian, Vegan)
VALUES

;

-- 16
DROP TABLE IF EXISTS RewardItems;
CREATE TABLE RewardItems (ItemNumber BIGINT PRIMARY KEY,
                          PointCost INT
);

INSERT INTO 
    RewardItems(ItemNumber, PointCost)
VALUES

;
