-- Change pickup method
UPDATE Orders
SET PickupMethod = 'Delivery'
WHERE OrderNumber = 6;

-- Change payment method
UPDATE Orders
SET PaymentMethod = 'Cash'
WHERE OrderNumber = 6;

-- Cancel order

DELETE FROM OrderItems
WHERE OrderNumber = 1;
DELETE FROM Orders
WHERE OrderNumber = 1;

-- Place order (see above data entry)

-- Add customer (see above data entry)

-- Add item to order
INSERT INTO 
    OrderItems(OrderNumber, ItemNumber, Quantity, Modifications)
VALUES
    (6, 
    (SELECT ItemNumber FROM Items WHERE ItemName = 'Christmas Burger'), 9, '')
;

-- Remove item from an order
DELETE FROM OrderItems
WHERE ItemNumber = (
    SELECT ItemNumber
    FROM Items
    WHERE ItemName = 'Medium Drink' AND OrderNumber = 6
);

-- Remove item from all orders
DELETE FROM OrderItems
WHERE ItemNumber = (
    SELECT ItemNumber
    FROM Items
    WHERE ItemName = 'Cheeseburger Combo'
);

--See all items in an order
SELECT * 
FROM OrderItems
ORDER BY OrderNumber
;
--See all orders by a customer
SELECT * 
FROM Orders
ORDER BY CustomerID
;
--See all Stores in a city
Select StoreNumber
FROM StoreBranch
WHERE AddressID IN
    (SELECT AddressID
    FROM Address
    WHERE City = 'Mason City')
;
--See all Item orders with modifications
SELECT ItemNumber, Modifications
FROM OrderItems
WHERE Modifications <> NULL
;
--See all items on the sides menu
SELECT ItemName
FROM Items
WHERE ItemNumber in 
    (SELECT ItemNumber
    FROM SideItems)
;
--Get all vegetarian options
SELECT ItemName
FROM Items
WHERE ItemNumber IN (
    SELECT ItemNumber
    FROM ItemNutrition
    WHERE Vegetarian = 1)
;
--Get all rewards items you can get with 600 points
SELECT ItemName
FROM Items
WHERE ItemNumber IN (
    SELECT ItemNumber
    FROM RewardItems
    WHERE PointCost <= 600)
;
