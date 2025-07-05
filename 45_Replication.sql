-- Replication

-- What is Replication?
-- Replication copies and distributes data from one database to another for redundancy and performance.
-- Used for high availability, load balancing, or reporting.

-- Types of Replication
-- Transactional: Replicates incremental changes in near real-time.
-- Snapshot: Copies entire dataset at a point in time.
-- Merge: Synchronizes bidirectional changes between databases.

-- Creating a Sample Table for Replication
CREATE DATABASE SourceDB;
GO
USE SourceDB;
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50)
);
GO
INSERT INTO Products (ProductID, ProductName)
VALUES (1, 'Laptop'), (2, 'Mouse');

-- Setting Up Transactional Replication (Conceptual)
-- Note: Replication setup typically uses SSMS GUI or scripts.
-- Enable database for replication.
EXEC sp_replicationdboption @dbname = 'SourceDB', @optname = 'publish', @value = 'true';
GO

-- Add publication (conceptual T-SQL).
EXEC sp_addpublication @publication = 'ProductPub', @database = 'SourceDB';
GO
EXEC sp_addarticle @publication = 'ProductPub', @article = 'Products', @source_object = 'Products';
GO

-- Querying Replicated Data (Assuming Subscriber)
-- In subscriber database:
SELECT * FROM Products;

-- Best Practices
-- Use transactional replication for real-time data needs.
-- Monitor replication latency and conflicts with SSMS tools.
-- Secure replication with appropriate permissions and encryption.
-- Test failover scenarios for high availability setups.
-- Document publication and subscription configurations.

-- Clean Up
DROP TABLE Products;
DROP DATABASE SourceDB;