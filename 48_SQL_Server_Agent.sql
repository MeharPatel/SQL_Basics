-- SQL Server Agent

-- What is SQL Server Agent?
-- SQL Server Agent is a component for automating and scheduling tasks in SQL Server.
-- Manages jobs, alerts, and operators for database maintenance and monitoring.

-- Key Components
-- Jobs: Automated tasks (e.g., backups, index maintenance).
-- Schedules: Define when jobs run.
-- Alerts: Notify on specific events or errors.
-- Operators: Recipients of notifications.

-- Creating a Sample Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Amount DECIMAL(10,2)
);
GO

-- Creating a Job (Conceptual)
-- Note: Jobs are typically created via SSMS, but T-SQL can configure them.
EXEC msdb.dbo.sp_add_job @job_name = 'DailySalesBackup';
EXEC msdb.dbo.sp_add_jobstep @job_name = 'DailySalesBackup', 
    @step_name = 'BackupSales', 
    @subsystem = 'TSQL', 
    @command = 'BACKUP DATABASE YourDB TO DISK = ''C:\Backups\Sales.bak''';
EXEC msdb.dbo.sp_add_jobschedule @job_name = 'DailySalesBackup', 
    @name = 'Daily', 
    @freq_type = 4, -- Daily
    @freq_interval = 1, 
    @active_start_time = 230000; -- 11:00 PM

-- Best Practices
-- Use SQL Server Agent for routine maintenance tasks like backups.
-- Configure alerts for critical errors (e.g., job failures).
-- Test job schedules in a non-production environment.
-- Monitor job history using msdb.dbo.sysjobhistory.
-- Secure SQL Server Agent with restricted permissions.

-- Clean Up
EXEC msdb.dbo.sp_delete_job @job_name = 'DailySalesBackup';
DROP TABLE Sales;