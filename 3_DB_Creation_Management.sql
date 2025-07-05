-- ### Database Creation and Management

-- **What is Database Creation and Management?**
-- - Involves creating, configuring, and maintaining SQL Server databases to store and organize data efficiently.
-- - Managed using Transact-SQL (T-SQL) commands or SQL Server Management Studio (SSMS).

-- **Key Concepts**
-- - **Database**: A structured collection of data, typically stored in tables.
-- - **Database Management**: Includes creating, altering, backing up, securing, and deleting databases.
-- - **Files**: Databases use two main file types:
--   - **Data Files (.mdf, .ndf)**: Store the actual data.
--   - **Log Files (.ldf)**: Record transactions for recovery and rollback.
-- - **Collation**: Defines how text data is sorted and compared (e.g., case-sensitive or case-insensitive).

-- **Creating a Database**
-- - Use the `CREATE DATABASE` statement to create a new database.
-- - Specify name, file locations, and optional settings like size and growth.

-- **Example**:
-- CREATE DATABASE InventoryDB;
-- GO

-- **Output**: Creates a database named "InventoryDB" with default settings.

-- **Advanced Create Example**:
CREATE DATABASE SalesDB
ON
( NAME = SalesDB_Data, 
  FILENAME = 'C:\SQLData\SalesDB.mdf',
  SIZE = 10MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 5MB )
LOG ON
( NAME = SalesDB_Log,
  FILENAME = 'C:\SQLData\SalesDB.ldf',
  SIZE = 5MB,
  MAXSIZE = 50MB,
  FILEGROWTH = 2MB );
GO

-- **Output**: Creates "SalesDB" with specific data and log file settings.

-- **Modifying a Database**
-- - Use `ALTER DATABASE` to change database properties, like size, files, or collation.

-- **Example**:
ALTER DATABASE InventoryDB
MODIFY FILE (NAME = InventoryDB_Data, SIZE = 20MB);
GO

-- **Output**: Increases the size of the "InventoryDB_Data" file to 20MB.

-- **Deleting a Database**
-- - Use `DROP DATABASE` to permanently delete a database and its files.

-- **Example**:
DROP DATABASE InventoryDB;
GO

-- **Output**: Deletes "InventoryDB" and its associated files.

-- **Database Options**
-- - Configure settings like recovery model, compatibility level, or auto-shrink.
-- - **Recovery Model**: Controls transaction logging (e.g., Simple, Full, Bulk-Logged).

-- **Example**:
ALTER DATABASE SalesDB
SET RECOVERY FULL;
GO

-- **Output**: Sets "SalesDB" to use the Full recovery model for complete transaction logging.

-- **Viewing Database Information**
-- - Use system views or commands to inspect databases.

-- **Example**:
SELECT name, create_date, collation_name
FROM sys.databases
WHERE name = 'SalesDB';

-- **Output**:
-- | name      | create_date         | collation_name              |
-- |-----------|---------------------|-----------------------------|
-- | SalesDB   | 2025-07-02 09:00:00 | SQL_Latin1_General_CP1_CI_AS |

-- **Attaching and Detaching Databases**
-- - **Detach**: Makes database files portable (using `sp_detach_db`).
-- - **Attach**: Reconnects database files to a SQL Server instance.

-- **Example (Detach)**:
EXEC sp_detach_db 'SalesDB';
GO

-- **Example (Attach)**:
CREATE DATABASE SalesDB
ON (FILENAME = 'C:\SQLData\SalesDB.mdf')
LOG ON (FILENAME = 'C:\SQLData\SalesDB.ldf')
FOR ATTACH;
GO

-- **Output**: Detaches and reattaches "SalesDB" to the server.

-- **Database Maintenance**
-- - Regular tasks include:
--   - **Backup**: Protect data using full or differential backups.
--   - **Index Maintenance**: Rebuild or reorganize indexes for performance.
--   - **Consistency Checks**: Use `DBCC CHECKDB` to verify database integrity.

-- **Example (Check Database)**:
DBCC CHECKDB ('SalesDB');
GO

-- **Output**: Reports any integrity issues in "SalesDB".

-- **Key Points**
-- - Use SSMS for a graphical interface to create and manage databases.
-- - Always specify appropriate file locations and growth settings for production databases.
-- - Regularly monitor and maintain databases to ensure performance and reliability.