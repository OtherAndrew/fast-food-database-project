DROP DATABASE IF EXISTS fast_food;
CREATE DATABASE fast_food;
USE fast_food;

-- 3
DROP TABLE IF EXISTS Address;
CREATE TABLE Address (AddressID INT PRIMARY KEY,
                      StreetAddress VARCHAR(255),
                      City VARCHAR(255),
                      ZIP INT,
                      State VARCHAR(255),
                      Country VARCHAR(255)
);

-- 5
DROP TABLE IF EXISTS StoreBranch;
CREATE TABLE StoreBranch (StoreNumber INT PRIMARY KEY,
                          AddressID INT,
                          Manager VARCHAR(255),
                          FOREIGN KEY(AddressID) REFERENCES Address(AddressID)
);

-- 1
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (CustomerID INT PRIMARY KEY,
                        Name VARCHAR(255),
                        RewardsPoints INT DEFAULT 0
);

-- 2
DROP TABLE IF EXISTS CustomerAddress;
CREATE TABLE CustomerAddress (CustomerID INT NOT NULL,
                              AddressID INT NOT NULL,
                              FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                              FOREIGN KEY(AddressID) REFERENCES Address(AddressID)
);

DROP TABLE IF EXISTS PaymentMethod;
CREATE TABLE PaymentMethod (Method VARCHAR(255) PRIMARY KEY);

INSERT INTO PaymentMethod(Method) VALUES ('Cash');
INSERT INTO PaymentMethod(Method) VALUES ('Credit card');
INSERT INTO PaymentMethod(Method) VALUES ('Gift card');
INSERT INTO PaymentMethod(Method) VALUES ('Rewards');

DROP TABLE IF EXISTS PickupMethod;
CREATE TABLE PickupMethod (Method VARCHAR(255) PRIMARY KEY);

INSERT INTO PickupMethod(Method) VALUES ('Drive-thru');
INSERT INTO PickupMethod(Method) VALUES ('Delivery');
INSERT INTO PickupMethod(Method) VALUES ('Walk in');
INSERT INTO PickupMethod(Method) VALUES ('Dine in');

-- 6
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (OrderNumber INT PRIMARY KEY,
                     StoreNumber INT,
                     CustomerID INT,
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
CREATE TABLE Items (ItemNumber INT PRIMARY KEY,
                    ItemName VARCHAR(255),
                    ItemDescription VARCHAR(255),
                    Price DECIMAL(10, 2)
);

DROP TABLE IF EXISTS ItemSize;
CREATE TABLE ItemSize (Size VARCHAR(255) PRIMARY KEY);

INSERT INTO ItemSize(Size) VALUES ('Small');
INSERT INTO ItemSize(Size) VALUES ('Medium');
INSERT INTO ItemSize(Size) VALUES ('Large');

DROP TABLE IF EXISTS EntreeItems;
CREATE TABLE EntreeItems (ItemNumber INT PRIMARY KEY,
                          FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

DROP TABLE IF EXISTS SideItems;
CREATE TABLE SideItems (ItemNumber INT PRIMARY KEY,
                        Size VARCHAR(255),
                        FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber),
                        FOREIGN KEY(Size) REFERENCES ItemSize(Size)
);

DROP TABLE IF EXISTS IceLevel;
CREATE TABLE IceLevel (Level VARCHAR(255) PRIMARY KEY);

INSERT INTO IceLevel(Level) VALUES ('Full');
INSERT INTO IceLevel(Level) VALUES ('Half');
INSERT INTO IceLevel(Level) VALUES ('No');

DROP TABLE IF EXISTS DrinkItems;
CREATE TABLE DrinkItems (ItemNumber INT PRIMARY KEY,
                         Size VARCHAR(255),
                         Ice VARCHAR(255) DEFAULT 'Full',
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber),
                         FOREIGN KEY(Size) REFERENCES ItemSize(Size),
                         FOREIGN KEY(Ice) REFERENCES IceLevel(Level)
);

DROP TABLE IF EXISTS LimitedItems;
CREATE TABLE LimitedItems (ItemNumber INT PRIMARY KEY,
                           Season VARCHAR(255),
                           FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

-- 15
DROP TABLE IF EXISTS BreakfastItems;
CREATE TABLE BreakfastItems (ItemNumber INT PRIMARY KEY,
                             FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

DROP TABLE IF EXISTS Combos;
CREATE TABLE Combos (ItemNumber INT PRIMARY KEY,
                     EntreeItemNumber INT NOT NULL,
                     SideItemNumber INT NOT NULL,
                     DrinkItemNumber INT NOT NULL,
                     FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber),
                     FOREIGN KEY(EntreeItemNumber) REFERENCES EntreeItems(ItemNumber),
                     FOREIGN KEY(SideItemNumber) REFERENCES SideItems(ItemNumber),
                     FOREIGN KEY(DrinkItemNumber) REFERENCES DrinkItems(ItemNumber)
);

DROP TABLE IF EXISTS OrderItems;
CREATE TABLE OrderItems (OrderNumber INT NOT NULL,
                         ItemNumber INT NOT NULL,
                         Quantity INT DEFAULT 1,
                         Modifications VARCHAR(255),
                         FOREIGN KEY(OrderNumber) REFERENCES Orders(OrderNumber),
                         FOREIGN KEY(ItemNumber) REFERENCES Items(ItemNumber)
);

-- 17
DROP TABLE IF EXISTS ItemNutrition;
CREATE TABLE ItemNutrition (ItemNumber INT PRIMARY KEY,
                            Calories INT,
                            Vegetarian INT DEFAULT 0,
                            Vegan INT DEFAULT 0
);

-- 16
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
