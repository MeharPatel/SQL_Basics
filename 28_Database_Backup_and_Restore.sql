-- Database Backup and Restore

-- What is Database Backup and Restore?
-- Backup: Creates a copy of a database to protect data from loss.
-- Restore: Recovers a database from a backup file to a previous state.
-- Ensures data recovery in case of hardware failure, corruption, or user errors.

-- Types of Backups
-- Full Backup: Captures entire database.
-- Differential Backup: Captures changes since the last full backup.
-- Transaction Log Backup: Captures transaction logs for point-in-time recovery (Full recovery model).

-- Creating a Sample Database for Examples
CREATE DATABASE SalesDB;
GO
USE SalesDB;
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);
INSERT INTO Orders (OrderID, OrderDate, Amount)
VALUES (1, '2023-01-15', 500.00),
       (2, '2023-02-10', 300.00);

-- Full Backup
-- Backs up the entire database to a file.
BACKUP DATABASE SalesDB
TO DISK = 'C:\Backups\SalesDB_Full.bak'
WITH INIT;

-- Differential Backup
-- Backs up changes since the last full backup.
BACKUP DATABASE SalesDB
TO DISK = 'C:\Backups\SalesDB_Diff.bak'
WITH DIFFERENTIAL, INIT;

-- Transaction Log Backup
-- Backs up transaction logs (requires Full or Bulk-Logged recovery model).
ALTER DATABASE SalesDB SET RECOVERY FULL;
BACKUP LOG SalesDB
TO DISK = 'C:\Backups\SalesDB_Log.trn'
WITH INIT;

-- Restoring a Database
-- Restores a full backup (database must be in NORECOVERY or RECOVERY state).
RESTORE DATABASE SalesDB
FROM DISK = 'C:\Backups\SalesDB_Full.bak'
WITH REPLACE, NORECOVERY;

-- Restoring Differential Backup
RESTORE DATABASE SalesDB
FROM DISK = 'C:\Backups\SalesDB_Diff.bak'
WITH NORECOVERY;

-- Restoring Transaction Log
RESTORE LOG SalesDB
FROM DISK = 'C:\Backups\SalesDB_Log.trn'
WITH RECOVERY;

-- Best Practices
-- Schedule regular backups (full, differential, log) based on data criticality.
-- Store backups in a secure, off-site location.
-- Test restores periodically to ensure backup reliability.
-- Use WITH CHECKSUM during backup to verify data integrity.
-- Document backup and restore procedures for disaster recovery.

-- Clean Up
USE master;
DROP DATABASE SalesDB;