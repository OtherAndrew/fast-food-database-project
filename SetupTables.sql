DROP DATABASE IF EXISTS fast_food;
CREATE DATABASE fast_food;
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

-- 5
DROP TABLE IF EXISTS StoreBranch;
CREATE TABLE StoreBranch (StoreNumber SERIAL PRIMARY KEY,
                          AddressID BIGINT UNSIGNED,
                          Manager VARCHAR(255),
                          FOREIGN KEY(AddressID) REFERENCES Address(AddressID)
);

-- 1
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (CustomerID SERIAL PRIMARY KEY,
                        Name VARCHAR(255),
                        RewardsPoints INT DEFAULT 0
);

-- 2
DROP TABLE IF EXISTS CustomerAddress;
CREATE TABLE CustomerAddress (CustomerID BIGINT UNSIGNED NOT NULL,
                              AddressID BIGINT UNSIGNED NOT NULL,
                              FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                              FOREIGN KEY(AddressID) REFERENCES Address(AddressID)
);

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
                     StoreNumber BIGINT UNSIGNED,
                     CustomerID BIGINT UNSIGNED,
                     PickupMethod VARCHAR(255),
                     PaymentMethod VARCHAR(255),
                     OrderTime TIMESTAMP,
                     FOREIGN KEY(StoreNumber) REFERENCES StoreBranch(StoreNumber),
                     FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                     FOREIGN KEY(PickupMethod) REFERENCES PickupMethod(Method),
                     FOREIGN KEY(PaymentMethod) REFERENCES PaymentMethod(Method)
);

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
    ('Bacon Breakfast Combo', 7.99),
;

DROP TABLE IF EXISTS EntreeItems;
CREATE TABLE EntreeItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
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
CREATE TABLE SideItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY
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
CREATE TABLE DrinkItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
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
CREATE TABLE LimitedItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
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
CREATE TABLE BreakfastItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
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
CREATE TABLE Combos (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
                     EntreeItemNumber BIGINT UNSIGNED NOT NULL,
                     SideItemNumber BIGINT UNSIGNED NOT NULL,
                     DrinkItemNumber BIGINT UNSIGNED NOT NULL,
                     FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber),
                     FOREIGN KEY(EntreeItemNumber) REFERENCES EntreeItems(ItemNumber),
                     FOREIGN KEY(SideItemNumber) REFERENCES SideItems(ItemNumber),
                     FOREIGN KEY(DrinkItemNumber) REFERENCES DrinkItems(ItemNumber)
);

DROP TABLE IF EXISTS OrderItems;
CREATE TABLE OrderItems (OrderNumber BIGINT UNSIGNED NOT NULL,
                         ItemNumber BIGINT UNSIGNED NOT NULL,
                         Quantity INT DEFAULT 1,
                         Modifications VARCHAR(255),
                         FOREIGN KEY(OrderNumber) REFERENCES Orders(OrderNumber),
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

-- 17
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
                            Calories INT,
                            Vegetarian INT DEFAULT 0,
                            Vegan INT DEFAULT 0
);

-- 16
DROP TABLE IF EXISTS RewardItems;
CREATE TABLE RewardItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
                          PointCost INT
);
