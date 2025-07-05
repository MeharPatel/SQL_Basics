-- Data Control Language (DCL)

-- What is DCL?
-- DCL (Data Control Language) is a subset of T-SQL used to manage access and permissions in SQL Server.
-- Controls who can access database objects and what actions they can perform.

-- Common DCL Commands
-- GRANT: Assigns permissions to users or roles.
-- REVOKE: Removes previously granted permissions.
-- DENY: Explicitly denies permissions to users or roles.

-- Key Concepts
-- Logins: Server-level credentials for accessing SQL Server.
-- Users: Database-level accounts mapped to logins.
-- Roles: Groups of permissions assigned to users for easier management.
-- Permissions: Specific actions (e.g., SELECT, INSERT, EXECUTE) on database objects.

-- Creating a Sample Table for Examples
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Budget DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Projects (ProjectID, ProjectName, Budget)
VALUES (1, 'Website Redesign', 50000.00),
       (2, 'Mobile App', 75000.00);

-- Creating a Login
-- Creates a SQL Server login (server-level).
CREATE LOGIN AppUser WITH PASSWORD = 'SecurePass123!';

-- Creating a User
-- Maps the login to a database user (database-level).
USE YourDatabaseName; -- Replace with actual database name
CREATE USER AppUser FOR LOGIN AppUser;

-- GRANT: Assigning Permissions
-- Grants specific permissions on a table to a user.
GRANT SELECT, INSERT ON Projects TO AppUser;

-- GRANT Permissions on Schema
-- Grants permissions on all objects in a schema.
CREATE SCHEMA Management;
GRANT SELECT ON SCHEMA::Management TO AppUser;

-- GRANT Permissions to a Role
-- Creates a role and assigns permissions to it.
CREATE ROLE ProjectViewer;
GRANT SELECT ON Projects TO ProjectViewer;
ALTER ROLE ProjectViewer ADD MEMBER AppUser;

-- REVOKE: Removing Permissions
-- Removes previously granted permissions.
REVOKE INSERT ON Projects FROM AppUser;

-- DENY: Explicitly Denying Permissions
-- Prevents a user from performing an action, even if granted via a role.
DENY UPDATE ON Projects TO AppUser;

-- Viewing Permissions
-- Displays permissions for a specific user or role.
SELECT * FROM sys.database_permissions
WHERE grantee_principal_id = DATABASE_PRINCIPAL_ID('AppUser');

-- Example with Multiple Permissions
-- Grants and tests permissions for a user.
CREATE LOGIN ReportUser WITH PASSWORD = 'ReportPass456!';
CREATE USER ReportUser FOR LOGIN ReportUser;
GRANT SELECT ON Projects TO ReportUser;
DENY DELETE ON Projects TO ReportUser;

-- Testing Permissions (as ReportUser)
-- This would be executed by ReportUser in a real scenario.
SELECT ProjectName, Budget FROM Projects;
-- The following would fail due to DENY:
-- DELETE FROM Projects WHERE ProjectID = 1;

-- Best Practices
-- Follow the principle of least privilege: grant only necessary permissions.
-- Use roles to manage permissions for multiple users efficiently.
-- Regularly audit permissions using sys.database_permissions or SSMS.
-- Use strong passwords for logins and enable password policies.
-- Avoid granting permissions directly to users; use roles instead.

-- Clean Up
DROP USER AppUser;
DROP LOGIN AppUser;
DROP USER ReportUser;
DROP LOGIN ReportUser;
DROP ROLE ProjectViewer;
DROP TABLE Projects;
DROP SCHEMA Management;