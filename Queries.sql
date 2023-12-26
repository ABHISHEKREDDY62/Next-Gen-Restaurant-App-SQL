-- 1.)Customers shall be able to view their own reservations after making them online.

SELECT R.Reservation_Id, R.Party_Size, R.Time_and_Date
FROM Reservation R
JOIN Customers C ON R.email = C.email
WHERE C.email = 'customer_email@example.com';


-- 2.)Analyze customer ordering habits in order to determine which items are popular or not.

SELECT
    oi.Item_Name,
    SUM(oi.Item_Qty) AS TotalQuantityOrdered
FROM
    Order_Items oi
GROUP BY
    oi.Item_Name
ORDER BY
    TotalQuantityOrdered DESC
LIMIT 1;


-- 3.)Generate receipts from orders and be able to store these receipts.

SELECT
    o.Order_Id,
    c.email,
    m.Item_Name,
    oi.Item_Qty,
    m.Item_Price,
    oi.Item_Qty * m.Item_Price AS Item_Total
FROM
    Orders o
JOIN
    Order_Items oi ON o.Order_Id = oi.Order_Id
JOIN
    Menu m ON oi.Item_Name = m.Item_Name
JOIN
    Customers c ON o.email = c.email
WHERE
    o.Order_Id = 2;


-- 4.)Analyze customer ordering habits in order to determine which items are popular or not.

SELECT
    Item_Name,
    SUM(Item_Qty) AS TotalQuantity
FROM
    Order_Items
GROUP BY
    Item_Name
HAVING
    SUM(Item_Qty) > 5;


-- 5.)The system shall account for gratuities made by customers on credit card transactions and associate those funds with the server so that payment is issued with the employee’s payroll.

SELECT
    o.Order_Id,
    SUM(oi.Item_Qty * m.Item_Price) AS TotalOrderAmount,
    p.Amount AS TotalPayment,
    (p.Amount - SUM(oi.Item_Qty * m.Item_Price)) AS TipAmount
FROM
    Orders o
JOIN
    Order_Items oi ON o.Order_Id = oi.Order_Id
JOIN
    Menu m ON oi.Item_Name = m.Item_Name
JOIN
    Payment p ON o.Order_Id = p.Order_Id
GROUP BY
    o.Order_Id, p.Amount
HAVING
    (p.Amount - SUM(oi.Item_Qty * m.Item_Price)) > 0;


-- 6.)A status screen of all order item details for each table will be available to kitchen staff for all open orders.

SELECT
    Order_Id,
    email,
    Status
FROM
    Orders
WHERE
    Status <> 'Completed';


-- 7.)Analyze customer ordering habits in order to determine which items are popular or not. ( to find orders that include specific items and have a total order amount greater than a certain value. In this example, we'll find orders that include the item 'Pizza' and have a total amount greater than $20).

SELECT
    Order_Id,
    email,
    TotalOrderAmount
FROM (
    SELECT
        o.Order_Id,
        o.email,
        SUM(oi.Item_Qty * m.Item_Price) AS TotalOrderAmount
    FROM
        Orders o
    JOIN
        Order_Items oi ON o.Order_Id = oi.Order_Id
    JOIN
        Menu m ON oi.Item_Name = m.Item_Name
    GROUP BY
        o.Order_Id, o.email
) AS OrderDetails
WHERE
    'Pizza' IN (
        SELECT DISTINCT
            Item_Name
        FROM
            Menu
    )
    AND TotalOrderAmount > 20;


-- 8.)Analyze customer ordering habits in order to determine which items are popular or not. (Consider a scenario where you want to retrieve a list of items that are either frequently ordered or have a high unit price. For example, suppose you want to find items that have been ordered more than 50 times or have a unit price greater than $10)

SELECT
    Item_Name,
    COUNT(*) AS OrderCount
FROM
    Order_Items
GROUP BY
    Item_Name
HAVING
    COUNT(*) > 50

UNION

-- Query for items with a high unit price
SELECT
    Item_Name,
    MAX(Item_Price) AS MaxUnitPrice
FROM
    Menu
GROUP BY
    Item_Name
HAVING
    MAX(Item_Price) > 10;


-- 9.)Retrieve the party size greater than avg party size for reservations made on each date.

SELECT
    Time_and_Date,
    AVG(Party_Size) AS AveragePartySize
FROM
    Reservation
GROUP BY
    Time_and_Date
HAVING
    AVG(Party_Size) > (
        SELECT
            AVG(Party_Size)
        FROM
            Reservation
    );
