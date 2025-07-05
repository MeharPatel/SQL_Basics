-- Always On Availability Groups

-- What are Always On Availability Groups?
-- A high-availability and disaster recovery solution in SQL Server (2012+).
-- Replicates databases across multiple servers (replicas) for failover and read-only access.

-- Key Components
-- Primary Replica: Handles read/write operations.
-- Secondary Replicas: Read-only copies for failover or reporting.
-- Availability Group: Group of databases replicated together.
-- Listener: Virtual network name for client connections.

-- Creating a Sample Database
CREATE DATABASE SalesDB;
GO
USE SalesDB;
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    Amount DECIMAL(10,2)
);
GO
INSERT INTO Orders (OrderID, Amount)
VALUES (1, 500.00), (2, 300.00);

-- Enable Always On (Conceptual)
-- Requires Windows Server Failover Cluster (WSFC) and enabling Always On in SQL Server Configuration Manager.
ALTER DATABASE SalesDB
SET HADR AVAILABILITY GROUP = SalesAG;
GO

-- Querying Availability Group Status
SELECT ag.name, ar.replica_server_name, dbs.database_name, dbs.synchronization_state_desc
FROM sys.availability_groups ag
JOIN sys.availability_replicas ar ON ag.group_id = ar.group_id
JOIN sys.dm_hadr_database_replica_states dbs ON ar.replica_id = dbs.replica_id
WHERE dbs.database_name = 'SalesDB';

-- Best Practices
-- Use synchronous commit for critical databases to ensure no data loss.
-- Configure secondary replicas for read-only reporting to offload primary.
-- Monitor failover and synchronization using DMVs or SSMS.
-- Test failover scenarios regularly.
-- Secure listener connections with appropriate permissions.

-- Clean Up
DROP TABLE Orders;
DROP DATABASE SalesDB;