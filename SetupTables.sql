DROP DATABASE IF EXISTS fast_food;
CREATE DATABASE fast_food;
USE fast_food;

-- 1
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (CustomerID SERIAL PRIMARY KEY,
                        Name VARCHAR(255),
                        Address VARCHAR(255),
                        RewardsPoints INT DEFAULT 0,
                        PreferredLocation INT
);

-- 2
DROP TABLE IF EXISTS Address;
CREATE TABLE Address (StreetAddress VARCHAR(255),
                      City VARCHAR(255),
                      ZIP INT,
                      State VARCHAR(255),
                      Country VARCHAR(255)
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
CREATE TABLE DeliveryAddress (CustomerID INT,
                              StreetAddress VARCHAR(255),
                              City VARCHAR(255),
                              ZIP INT,
                              State VARCHAR(255),
                              Country VARCHAR(255)
);

-- 5
DROP TABLE IF EXISTS Combos;
CREATE TABLE Combos (ComboNumber INT PRIMARY KEY,
                     ComboName VARCHAR(255),
                     Entree INT,
                     Side INT,
                     Drink INT,
                     Price DECIMAL(10,2)/*
                     ,
                     FOREIGN KEY(Entree) REFERENCES Entrees(Entree),
                     FOREIGN KEY(Side) REFERENCES Sides(Side),
                     FOREIGN KEY(Drink) REFERENCES Drinks(Drink)*/
);

-- 6
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (OrderNumber SERIAL PRIMARY KEY,
                     Item INT,
                     OrderQuantity INT,
                     PickupMethod VARCHAR(255),
                     OrderTime TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
                     Fulfilled INT DEFAULT 0
);

-- 7
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (ItemNumber INT PRIMARY KEY,
                    BreakfastItem INT DEFAULT 0
);

-- 7.1
DROP TABLE IF EXISTS ItemPrices;
CREATE TABLE ItemPrices (ItemNumber INT PRIMARY KEY,
                         Price DECIMAL(10, 2)
);

-- 7.2
DROP TABLE IF EXISTS ItemStock;
CREATE TABLE ItemStock (ItemNumber INT PRIMARY KEY,
                        StockQuantity INT
);

-- 7.3
DROP TABLE IF EXISTS ItemNames;
CREATE TABLE ItemNames (ItemNumber INT PRIMARY KEY,
                        Name VARCHAR(255)
);

-- 8
DROP TABLE IF EXISTS Sauces;
CREATE TABLE Sauces (ItemNumber INT PRIMARY KEY,
                     MaximumQuantity INT
);

-- 11
DROP TABLE IF EXISTS Drinks;
CREATE TABLE Drinks (ItemNumber INT PRIMARY KEY,
                     HotDrink INT DEFAULT 0
);

-- 14
DROP TABLE IF EXISTS OrderPayment;
CREATE TABLE OrderPayment (OrderNumber INT PRIMARY KEY,
                           Price DECIMAL(10, 2),
                           PaymentMethod VARCHAR(255)
);

-- 15
DROP TABLE IF EXISTS CreditCard;
CREATE TABLE CreditCard (CreditCardNumber INT PRIMARY KEY,
                         FirstName VARCHAR(255),
                         LastName VARCHAR(255),
                         ExpirationMonth INT,
                         ExpirationYear INT,
                         SecurityCode INT
);

-- 16
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber SERIAL PRIMARY KEY,
                            Calories VARCHAR(255),
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
