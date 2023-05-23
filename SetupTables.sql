DROP DATABASE IF EXISTS fast_food;
CREATE DATABASE fast_food;
USE fast_food;

-- 1


-- 3
DROP TABLE IF EXISTS StoreLocation;
CREATE TABLE StoreLocation (StoreNumber INT PRIMARY KEY,
                            Name VARCHAR(255),
                            Manager VARCHAR(255)
);

DROP TABLE IF EXISTS StoreAddress;
CREATE TABLE StoreAddress (StoreNumber INT PRIMARY KEY,
                           StreetAddress VARCHAR(255),
                           City VARCHAR(255),
                           ZIP INT,
                           State VARCHAR(255),
                           Country VARCHAR(255)
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (CustomerID INT PRIMARY KEY,
                        Name VARCHAR(255),
                        Address VARCHAR(255),
                        RewardsPoints INT DEFAULT 0,
                        PreferredLocation INT,
                        FOREIGN KEY(PreferredLocation) REFERENCES StoreLocation(StoreNumber)
);

DROP TABLE IF EXISTS CreditCard;
CREATE TABLE CreditCard (CreditCardNumber INT PRIMARY KEY,
                         FirstName VARCHAR(255) NOT NULL,
                         LastName VARCHAR(255) NOT NULL,
                         ExpirationMonth INT NOT NULL,
                         ExpirationYear INT NOT NULL,
                         SecurityCode INT NOT NULL
);

-- 14
DROP TABLE IF EXISTS OrderPayment;
CREATE TABLE OrderPayment (OrderNumber INT NOT NULL,
                           PaymentAmount INT,
                           PaymentMethod VARCHAR(255),
                           CreditCardNumber INT,
                           FOREIGN KEY(CreditCardNumber) REFERENCES CreditCard(CreditCardNumber)
);

DROP TABLE IF EXISTS PickupMethod;
CREATE TABLE PickupMethod (Method VARCHAR(255) PRIMARY KEY);

INSERT INTO PickupMethod(Method) VALUES ('Drive-thru');
INSERT INTO PickupMethod(Method) VALUES ('Delivery');
INSERT INTO PickupMethod(Method) VALUES ('Walk in');
INSERT INTO PickupMethod(Method) VALUES ('Dine in');

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (OrderNumber INT PRIMARY KEY,
                     StoreNumber INT,
                     CustomerID INT,
                     PickupMethod VARCHAR(255),
                     OrderTime TIMESTAMP,
                     Fulfilled INT DEFAULT 0,
                     FOREIGN KEY(StoreNumber) REFERENCES StoreLocation(StoreNumber),
                     FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                     FOREIGN KEY(PickupMethod) REFERENCES PickupMethod(Method)
);

DROP TABLE IF EXISTS DeliveryAddress;
CREATE TABLE DeliveryAddress (OrderNumber INT PRIMARY KEY,
                              StreetAddress VARCHAR(255),
                              City VARCHAR(255),
                              ZIP INT,
                              State VARCHAR(255),
                              Country VARCHAR(255)
);

-- 7
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (ItemNumber INT PRIMARY KEY,
                    ItemName VARCHAR(255),
                    Price DECIMAL(10, 2),
                    StockQuantity INT
);

DROP TABLE IF EXISTS BreakfastItems;
CREATE TABLE BreakfastItems (ItemNumber INT PRIMARY KEY);

DROP TABLE IF EXISTS OrderItems;
CREATE TABLE OrderItems (OrderNumber INT NOT NULL,
                         ItemNumber INT NOT NULL,
                         Modifications VARCHAR(255),
                         OrderQuantity INT DEFAULT 1,
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

DROP TABLE IF EXISTS Combos;
CREATE TABLE Combos (ItemNumber INT PRIMARY KEY,
                     EntreeItemNumber INT,
                     SideItemNumber INT,
                     DrinkItemNumber INT,
                     FOREIGN KEY(EntreeItemNumber) REFERENCES Items(ItemNumber),
                     FOREIGN KEY(SideItemNumber) REFERENCES Items(ItemNumber),
                     FOREIGN KEY(DrinkItemNumber) REFERENCES Items(ItemNumber)
);

-- 8
DROP TABLE IF EXISTS Sauces;
CREATE TABLE Sauces (ItemNumber INT PRIMARY KEY,
                     MaximumQuantity INT
);

-- 11
DROP TABLE IF EXISTS Drinks;
CREATE TABLE Drinks (ItemNumber INT PRIMARY KEY,
                     Size VARCHAR(255),
                     HotDrink INT DEFAULT 0
);
-- 15

-- 16
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber INT PRIMARY KEY,
                            Calories INT,
                            Vegetarian INT DEFAULT 0,
                            Vegan INT DEFAULT 0
);

DROP TABLE IF EXISTS RewardItems;
CREATE TABLE RewardItems (ItemNumber INT PRIMARY KEY,
                          PointCost INT
);

-- 17

--- Example code below
/*
DROP TABLE IF EXISTS Contacts;
CREATE TABLE Contacts(PrimaryKey SERIAL PRIMARY KEY,
                      MemberID_A INT NOT NULL,
                      MemberID_B INT NOT NULL,
                      Verified INT DEFAULT 0,
                      FOREIGN KEY(MemberID_A) REFERENCES Members(MemberID),
                      FOREIGN KEY(MemberID_B) REFERENCES Members(MemberID)
);

DROP TABLE IF EXISTS Chats;
CREATE TABLE Chats (ChatID SERIAL PRIMARY KEY,
                    Name VARCHAR(255)
);

DROP TABLE IF EXISTS ChatMembers;
CREATE TABLE ChatMembers (ChatID INT NOT NULL,
                          MemberID INT NOT NULL,
                          FOREIGN KEY(MemberID) REFERENCES Members(MemberID),
                          FOREIGN KEY(ChatID) REFERENCES Chats(ChatID)
);

DROP TABLE IF EXISTS Messages;
CREATE TABLE Messages (PrimaryKey SERIAL PRIMARY KEY,
                       ChatID INT,
                       Message VARCHAR(255),
                       MemberID INT,
                       FOREIGN KEY(MemberID) REFERENCES Members(MemberID),
                       FOREIGN KEY(ChatID) REFERENCES Chats(ChatID),
                       TimeStamp TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp
);

DROP TABLE IF EXISTS Locations;
CREATE TABLE Locations (PrimaryKey SERIAL PRIMARY KEY,
                        MemberID INT,
                        Nickname VARCHAR(255),
                        Lat DECIMAL,
                        Long DECIMAL,
                        ZIP INT,
                        FOREIGN KEY(MemberID) REFERENCES Members(MemberID)
);

DROP TABLE IF EXISTS Push_Token;
CREATE TABLE Push_Token (KeyID SERIAL PRIMARY KEY,
                        MemberID INT NOT NULL UNIQUE,
                        Token VARCHAR(255),
                        FOREIGN KEY(MemberID) REFERENCES Members(MemberID)
);
*/
