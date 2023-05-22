DROP DATABASE IF EXISTS fast_food;
CREATE DATABASE fast_food;
USE fast_food;

-- 1
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (CustomerID INT PRIMARY KEY,
                        Name VARCHAR(255),
                        Address VARCHAR(255),
                        RewardsPoints INT DEFAULT 0,
                        PreferredLocation INT
);

-- 3
DROP TABLE IF EXISTS StoreLocation;
CREATE TABLE StoreLocation (StoreNumber INT PRIMARY KEY,
                            Name VARCHAR(255),
                            Manager VARCHAR(255)
);

-- 3.1
DROP TABLE IF EXISTS StoreAddress;
CREATE TABLE StoreAddress (StoreNumber INT PRIMARY KEY,
                           StreetAddress VARCHAR(255),
                           City VARCHAR(255),
                           ZIP INT,
                           State VARCHAR(255),
                           Country VARCHAR(255)
);

-- 4
DROP TABLE IF EXISTS DeliveryAddress;
CREATE TABLE DeliveryAddress (OrderNumber INT PRIMARY KEY,
                              StreetAddress VARCHAR(255),
                              City VARCHAR(255),
                              ZIP INT,
                              State VARCHAR(255),
                              Country VARCHAR(255)
);

-- 6
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (OrderNumber INT PRIMARY KEY,
                     StoreNumber INT,
                     CustomerID INT,
                     PickupMethod VARCHAR(255),
                     OrderTime TIMESTAMP,
                     Fulfilled INT DEFAULT 0
);

-- 7
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (ItemNumber INT PRIMARY KEY,
                    Name VARCHAR(255),
                    Price DECIMAL(10, 2),
                    Modifications VARCHAR(255),
                    BreakfastItem INT DEFAULT 0
);

DROP TABLE IF EXISTS OrderItems;
CREATE TABLE OrderItems (OrderNumber NOT NULL INT,
                         ItemNumber NOT NULL INT,
                         OrderQuantity INT DEFAULT 1
);

DROP TABLE IF EXISTS Combos;
CREATE TABLE Combos (ItemNumber INT PRIMARY KEY,
                     EntreeItemNumber NOT NULL INT,
                     SideItemNumber NOT NULL INT,
                     DrinkItemNumber NOT NULL INT,
                     FOREIGN KEY(EntreeItemNumber) REFERENCES Items(EntreeItemNumber),
                     FOREIGN KEY(SideItemNumber) REFERENCES Items(SideItemNumber),
                     FOREIGN KEY(DrinkItemNumber) REFERENCES Items(DrinkItemNumber)
);

-- 7.2
DROP TABLE IF EXISTS ItemStock;
CREATE TABLE ItemStock (ItemNumber INT PRIMARY KEY,
                        StockQuantity INT
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

-- 14
DROP TABLE IF EXISTS OrderPayment;
CREATE TABLE OrderPayment (OrderNumber NOT NULL INT,
                           PaymentAmount INT,
                           PaymentMethod VARCHAR(255),
                           CreditCardNumber INT
);

-- 15
DROP TABLE IF EXISTS CreditCard;
CREATE TABLE CreditCard (CreditCardNumber INT PRIMARY KEY,
                         FirstName NOT NULL VARCHAR(255),
                         LastName NOT NULL VARCHAR(255),
                         ExpirationMonth NOT NULL INT,
                         ExpirationYear NOT NULL INT,
                         SecurityCode NOT NULL INT
);

-- 16
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber INT PRIMARY KEY,
                            Calories INT,
                            Vegetarian INT DEFAULT 0,
                            Vegan INT DEFAULT 0
);

-- 17
DROP TABLE IF EXISTS PickupMethod;
CREATE TABLE PickupMethod (OrderNumber INT PRIMARY KEY,
                           Method VARCHAR(255),
                           PickupTime TIMESTAMP
); 

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
