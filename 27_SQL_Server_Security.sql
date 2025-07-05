-- SQL Server Security (Logins, Users, Roles, Permissions)

-- What is SQL Server Security?
-- SQL Server security manages access to the database server and its objects.
-- Uses logins (server-level), users (database-level), roles, and permissions to control access.

-- Key Components
-- Logins: Server-level accounts for accessing SQL Server.
-- Users: Database-level accounts mapped to logins.
-- Roles: Groups of permissions for easier management.
-- Permissions: Specific actions (e.g., SELECT, INSERT) on objects.

-- Creating a Sample Table for Examples
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    Budget DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Projects (ProjectID, ProjectName, Budget)
VALUES (1, 'Website', 50000.00),
       (2, 'Mobile App', 75000.00);

-- Creating a Login
-- Creates a SQL Server login.
CREATE LOGIN ProjectUser WITH PASSWORD = 'SecurePass123!';

-- Creating a User
-- Maps the login to a database user.
USE YourDatabaseName; -- Replace with actual database name
CREATE USER ProjectUser FOR LOGIN ProjectUser;

-- Creating a Role
-- Groups permissions for multiple users.
CREATE ROLE ProjectReader;

-- Granting Permissions
-- Grants SELECT permission on Projects table to the user.
GRANT SELECT ON Projects TO ProjectUser;

-- Granting Permissions to a Role
GRANT SELECT, UPDATE ON Projects TO ProjectReader;

-- Adding User to Role
ALTER ROLE ProjectReader ADD MEMBER ProjectUser;

-- Denying Permissions
-- Explicitly denies DELETE permission.
DENY DELETE ON Projects TO ProjectUser;

-- Revoking Permissions
-- Removes previously granted permissions.
REVOKE UPDATE ON Projects FROM ProjectReader;

-- Viewing Permissions
-- Displays permissions for a user or role.
SELECT * FROM sys.database_permissions
WHERE grantee_principal_id = DATABASE_PRINCIPAL_ID('ProjectUser');

-- Best Practices
-- Follow the principle of least privilege: grant only necessary permissions.
-- Use roles to simplify permission management for multiple users.
-- Regularly audit logins, users, and permissions using sys.database_principals and sys.database_permissions.
-- Use strong passwords and enable password policies for logins.
-- Avoid granting direct permissions to users; prefer roles.

-- Clean Up
DROP USER ProjectUser;
DROP LOGIN ProjectUser;
DROP ROLE ProjectReader;
DROP TABLE Projects;