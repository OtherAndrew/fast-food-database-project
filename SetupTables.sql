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
                      Country VARCHAR(255),
                      CONSTRAINT unique_address UNIQUE (StreetAddress, City, ZIP)
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
                          AddressID BIGINT UNSIGNED NOT NULL,
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
CREATE TABLE CustomerAddress (CustomerID BIGINT UNSIGNED NOT NULL,
                              AddressID BIGINT UNSIGNED NOT NULL,
                              FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                              FOREIGN KEY(AddressID) REFERENCES Address(AddressID),
                              CONSTRAINT unique_customer_address UNIQUE (CustomerID, AddressID)
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
                     StoreNumber BIGINT UNSIGNED NOT NULL,
                     CustomerID BIGINT UNSIGNED NOT NULL,
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
CREATE TABLE SideItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
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
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
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
    LimitedItems(ItemNumber, Season)
VALUES 
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Halloween Burger'), 'Fall'),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Christmas Burger'), 'Winter')
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

INSERT INTO 
    Combos(ItemNumber, EntreeItemNumber, SideItemNumber, DrinkItemNumber)
VALUES
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink')
    ),
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink')
    ),
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Double Hamburger Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Double Hamburger'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink')
    ),
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink')
    ),
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Sandwich'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Drink')
    ),
    (
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Combo'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Sandwich'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'),
        (SELECT ItemNumber FROM Items WHERE ItemName = 'Small Drink')
    )
;

DROP TABLE IF EXISTS OrderItems;
CREATE TABLE OrderItems (OrderNumber BIGINT UNSIGNED NOT NULL,
                         ItemNumber BIGINT UNSIGNED NOT NULL,
                         Quantity INT DEFAULT 1,
                         Modifications VARCHAR(255),
                         FOREIGN KEY(OrderNumber) REFERENCES Orders(OrderNumber),
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

INSERT INTO 
    OrderItems(OrderNumber, ItemNumber, Quantity, Modifications)
VALUES
    (1, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'), 2, NULL),
    (1,
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Sandwich'), 2, NULL),
    (2, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger Combo'), 1, 'No pickles'),
    (3, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Large Fries'), 1, NULL),
    (4, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger Combo'), 1, NULL),
    (5, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger Combo'), 1, 'No lettuce or pickles'),
    (6, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger'), 3, NULL),
    (6, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink'), 3, 'No ice')

;

-- 17
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
                            Calories INT,
                            Vegetarian INT DEFAULT 0,
                            Vegan INT DEFAULT 0
);

INSERT INTO 
    ItemNutrition(ItemNumber, Calories, Vegetarian, Vegan)
VALUES
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger'), 600, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger'), 620, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Hamburger'), 800, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger'), 820, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Sandwich'), 500, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Sandwich'), 530, 0,0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Halloween Burger'), 666, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Christmas Burger'), 700, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Small Fries'), 150, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Large Fries'), 200, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Onion Rings'), 300, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Pickle Chips'), 300, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'), 200, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Small Drink'), 200, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Medium Drink'), 250, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Large Drink'), 300, 1, 1),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger Combo'), 1000, 0,0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger Combo'), 1020, 0,0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Hamburger Combo'), 1200, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger Combo'), 1220, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Combo'), 900, 0, 0),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Combo'), 930, 0, 0)
;

-- 16
DROP TABLE IF EXISTS RewardItems;
CREATE TABLE RewardItems (ItemNumber BIGINT UNSIGNED PRIMARY KEY,
                          PointCost INT
);

INSERT INTO 
    RewardItems(ItemNumber, PointCost)
VALUES
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hamburger'), 800),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Cheeseburger'), 900),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Hamburger'), 1000),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Double Cheeseburger'), 1100),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Large Fries'), 300),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Large Drink'), 400),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Onion Rings'), 500),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Pickle Chips'), 500),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Hash Browns'), 500),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Sausage Breakfast Sandwich'), 800),
    ((SELECT ItemNumber FROM Items WHERE ItemName = 'Bacon Breakfast Sandwich'), 800)
;
