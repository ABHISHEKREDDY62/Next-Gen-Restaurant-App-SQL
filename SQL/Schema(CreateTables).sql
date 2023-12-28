-- Customers
CREATE TABLE Customers (
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL,
    mobile INTEGER NOT NULL,
    PRIMARY KEY (email)
);

-- Reservation
CREATE TABLE Reservation (
    Reservation_Id INTEGER NOT NULL,
    Party_Size INTEGER NOT NULL,
    email VARCHAR(30) NOT NULL,
    Time_and_Date TIMESTAMP NOT NULL,
    PRIMARY KEY (Reservation_Id),
    FOREIGN KEY (email) REFERENCES Customers (email)
);

-- Tables
CREATE TABLE Tables (
    Table_Number INTEGER NOT NULL,
    Max_Occupancy INTEGER NOT NULL,
    PRIMARY KEY (Table_Number)
);

-- Employees
CREATE TABLE Employees (
    Employees_Id INTEGER NOT NULL,
    MGR_Id INTEGER NOT NULL,
    DOB DATE NOT NULL,
    Shift_Timings VARCHAR(25) NOT NULL,
    Pay_Roll INTEGER NOT NULL,
    Role VARCHAR(15) NOT NULL,
    Login VARCHAR(100) NOT NULL,
    PRIMARY KEY (Employees_Id)
);


-- Menu

CREATE TABLE Menu (
    Item_Price INTEGER NOT NULL,
    Item_Name VARCHAR(50) NOT NULL,
    Item_Description VARCHAR(100) NOT NULL,
    Item_Category VARCHAR(40) NOT NULL,
    PRIMARY KEY (Item_Name)
);

-- Orders
CREATE TABLE Orders (
    Order_Id INTEGER NOT NULL,
    Table_Number INTEGER NOT NULL,
    email VARCHAR(30) NOT NULL,
    Status VARCHAR(25) NOT NULL,
    Reservation_Id INTEGER NOT NULL,
    Employees_Id INTEGER NOT NULL,
    PRIMARY KEY (Order_Id),
    FOREIGN KEY (Table_Number) REFERENCES Tables (Table_Number),
    FOREIGN KEY (email) REFERENCES Customers (email),
    FOREIGN KEY (Reservation_Id) REFERENCES Reservation (Reservation_Id),
    FOREIGN KEY (Employees_Id) REFERENCES Employees (Employees_Id)
);


-- Order_Items
CREATE TABLE Order_Items (
    Order_Id INTEGER NOT NULL,
    Item_Qty INTEGER NOT NULL,
    Item_Name VARCHAR(50) NOT NULL,
    PRIMARY KEY (Order_Id, Item_Name),
    FOREIGN KEY (Order_Id) REFERENCES Orders (Order_Id),
    FOREIGN KEY (Item_Name) REFERENCES Menu (Item_Name)
);

-- Payment
CREATE TABLE Payment (
    Payment_Id INTEGER NOT NULL,
    Order_Id INTEGER NOT NULL,
    Payment_Mode VARCHAR(30) NOT NULL,
    Amount INTEGER NOT NULL,
    PRIMARY KEY (Payment_Id),
    FOREIGN KEY (Order_Id) REFERENCES Orders (Order_Id)
);

-- Inventory
CREATE TABLE Inventory (
    Material_Name VARCHAR(30) NOT NULL,
    Quantity INTEGER NOT NULL,
    PRIMARY KEY (Material_Name)
);

-- Updates
CREATE TABLE Updates (
    Employees_Id INTEGER NOT NULL,
    Material_Name VARCHAR(30) NOT NULL,
    Permission_Password VARCHAR(30) NOT NULL,
    PRIMARY KEY (Employees_Id, Material_Name),
    FOREIGN KEY (Employees_Id) REFERENCES Employees (Employees_Id),
    FOREIGN KEY (Material_Name) REFERENCES Inventory (Material_Name)
);
