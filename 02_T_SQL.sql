-- ### Transact-SQL (T-SQL)

-- **What is T-SQL?**
-- - Transact-SQL (T-SQL) is Microsoft’s proprietary extension of SQL (Structured Query Language) used in SQL Server.
-- - Enhances standard SQL with additional features for querying, manipulating, and controlling data, as well as programming constructs.

-- **Key Characteristics**
-- - Used to interact with SQL Server databases for tasks like data retrieval, updates, and management.
-- - Includes procedural programming capabilities (e.g., loops, conditionals) unlike standard SQL.
-- - Case-insensitive for keywords and identifiers.

-- **Main Components**
-- - **Data Definition Language (DDL)**: Commands to define database structure (e.g., CREATE, ALTER, DROP).
-- - **Data Manipulation Language (DML)**: Commands to manipulate data (e.g., SELECT, INSERT, UPDATE, DELETE).
-- - **Data Control Language (DCL)**: Commands to manage access and permissions (e.g., GRANT, REVOKE).
-- - **Control-of-Flow**: Constructs like IF, WHILE, BEGIN…END for procedural logic.
-- - **Variables**: Store temporary data for processing.
-- - **Error Handling**: TRY…CATCH blocks for managing errors.

-- **Example**: Creating and querying a table using T-SQL.
-- Create a table (DDL)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

-- Insert data (DML)
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 999.99);

-- Query data (DML)
SELECT ProductName, Price FROM Products WHERE Price > 500;

-- Grant permission (DCL)
GRANT SELECT ON Products TO User1;

-- **Output**:
-- | ProductName | Price   |
-- |-------------|---------|
-- | Laptop      | 999.99  |

-- **Control-of-Flow Example**:
DECLARE @Price DECIMAL(10,2) = 999.99;
IF @Price > 500
BEGIN
    PRINT 'Price is high!';
END
ELSE
BEGIN
    PRINT 'Price is affordable.';
END

-- **Output**: Price is high!

-- **Variables Example**:
DECLARE @ProductCount INT;
SELECT @ProductCount = COUNT(*) FROM Products;
PRINT 'Total products: ' + CAST(@ProductCount AS VARCHAR);

-- **Output**: Total products: 1

-- **Error Handling Example**:
BEGIN TRY
    INSERT INTO Products (ProductID, ProductName, Price)
    VALUES (1, 'Mouse', 29.99); -- Duplicate ProductID causes error
END TRY
BEGIN CATCH
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH

-- **Output**: Error: Violation of PRIMARY KEY constraint...

-- **Common T-SQL Features**
-- - **Functions**: Built-in (e.g., GETDATE(), LEN()) or user-defined.
-- - **Joins**: Combine data from multiple tables (e.g., INNER JOIN, LEFT JOIN).
-- - **Subqueries**: Nested queries for complex data retrieval.
-- - **Batch Processing**: Execute multiple statements together, separated by GO.
-- - **Comments**: Use -- for single-line or /* */ for multi-line comments.

-- **Example with Join**:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT
);

INSERT INTO Orders (OrderID, ProductID, Quantity)
VALUES (1, 1, 5);

SELECT p.ProductName, o.Quantity
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

-- **Output**:
-- | ProductName | Quantity |
-- |-------------|----------|
-- | Laptop      | 5        |

-- **Key Points**
-- - T-SQL scripts are executed in SQL Server Management Studio (SSMS) or other compatible tools.
-- - Enhances SQL with programming logic for automation and complex tasks.
-- - Essential for stored procedures, triggers, and functions in SQL Server.