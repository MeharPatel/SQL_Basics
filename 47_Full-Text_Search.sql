-- Full-Text Search

-- What is Full-Text Search?
-- Full-Text Search enables efficient searching of text data in SQL Server.
-- Supports complex queries like word searches, phrase searches, and proximity searches.

-- Key Components
-- Full-Text Index: Indexes text columns for fast searching.
-- Full-Text Catalog: Container for full-text indexes.
-- Predicates: CONTAINS, FREETEXT for searching.
-- Functions: CONTAINSTABLE, FREETEXTTABLE for ranking results.

-- Creating a Sample Table
CREATE TABLE Documents (
    DocID INT PRIMARY KEY,
    Title VARCHAR(100),
    Content NVARCHAR(MAX)
);
GO

-- Creating a Full-Text Catalog
CREATE FULLTEXT CATALOG DocCatalog;
GO

-- Creating a Full-Text Index
CREATE FULLTEXT INDEX ON Documents(Content)
KEY INDEX PK_Documents ON DocCatalog;
GO

-- Inserting Sample Data
INSERT INTO Documents (DocID, Title, Content)
VALUES (1, 'SQL Guide', 'SQL Server is a powerful database platform.'),
       (2, 'T-SQL Intro', 'Learn T-SQL for querying SQL Server.');

-- Full-Text Search with CONTAINS
SELECT Title, Content
FROM Documents
WHERE CONTAINS(Content, 'SQL');

-- Full-Text Search with FREETEXT
SELECT Title, Content
FROM Documents
WHERE FREETEXT(Content, 'database platform');

-- Best Practices
-- Create full-text indexes on large text columns (NVARCHAR, VARCHAR).
-- Update full-text indexes regularly for new data.
-- Use FREETEXT for natural language searches, CONTAINS for precise matches.
-- Monitor full-text index size and performance.
-- Secure full-text catalogs with appropriate permissions.

-- Clean Up
DROP FULLTEXT INDEX ON Documents;
DROP FULLTEXT CATALOG DocCatalog;
DROP TABLE Documents;