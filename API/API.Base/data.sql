CREATE TABLE tblTypes(

	Id		INT		PRIMARY KEY,

	Title	NVARCHAR(128) NOT NULL,

	Slug	NVARCHAR(128) NOT NULL,

	DateAdded	DATETIME NOT NULL DEFAULT(GETDATE()),

	IsActive	BIT NOT NULL DEFAULT(0)

);


-- SEEDING TYPE DATA

INSERT INTO tblTypes (Id, Title, Slug, DateAdded, IsActive) 
VALUES 
(0, 'Untyped', 'untyped', GETDATE(), 1),
(1, 'Blog', 'blog', GETDATE(), 1),
(2, 'Music', 'music', GETDATE(), 1),
(3, 'Gallery', 'gallery', GETDATE(), 1),
(4, 'Artifact', 'artifact', GETDATE(), 1),
(5, 'App', 'app', GETDATE(), 0);



CREATE TABLE tblCategories(

	Id		INT		PRIMARY KEY,

	Title	NVARCHAR(128) NOT NULL,

	Slug	NVARCHAR(128) NOT NULL,

	DateAdded	DATETIME NOT NULL DEFAULT(GETDATE()),

	IsActive	BIT NOT NULL DEFAULT(0)

);


INSERT INTO tblCategories (Id, Title, Slug, DateAdded, IsActive) 
VALUES 
(0, 'Uncategorized', 'uncategorized', GETDATE(), 1),
(1, 'Life', 'life', GETDATE(), 1),
(2, 'Travel', 'Travel', GETDATE(), 1),
(3, 'Gallery', 'gallery', GETDATE(), 1),
(4, 'Artifact', 'artifact', GETDATE(), 1),
(5, 'App', 'app', GETDATE(), 0);



CREATE TABLE tblContent(

	Id		INT		PRIMARY KEY,

	TypeId	INT FOREIGN KEY(TypeId) REFERENCES tblTypes(Id)	 NOT NULL DEFAULT(0),

	CategoryId	INT FOREIGN KEY(CategoryId) REFERENCES tblCategories(Id) NOT NULL DEFAULT(0),

	ContentKey	UNIQUEIDENTIFIER NOT NULL DEFAULT(NEWID()),

	ContentData	NVARCHAR(MAX)	NOT NULL DEFAULT('{}'),

	Title	NVARCHAR(128) NOT NULL,

	Slug	NVARCHAR(128) NOT NULL,

	[Description]	NVARCHAR(255)	NOT NULL DEFAULT('placeholder'),

	DateAdded	DATETIME NOT NULL DEFAULT(GETDATE()),

	IsActive	BIT NOT NULL DEFAULT(0)

);