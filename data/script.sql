CREATE TABLE tblLogs(
	Id				INT         PRIMARY KEY,
    [User]          INT,   
	[UserAgent]     NVARCHAR(255),
	[Description]	NVARCHAR(255)		NOT NULL,
	DateAdded		DATETIME            NOT NULL	DEFAULT(GETDATE())
);

CREATE TABLE tblMessages(

	Id				INT                 PRIMARY KEY,								
	[UserId]        INT,
	[Message]		NVARCHAR(255)       NOT NULL,
	[Origin]        NVARCHAR(255)       NOT NULL    DEFAULT('na'),
    DateAdded		DATETIME            NOT NULL	DEFAULT(GETDATE()),
	IsRead		    BIT					NOT NULL	DEFAULT(0)

);

CREATE TABLE tblRoles(
    Id				INT             PRIMARY KEY,		
    Title           NVARCHAR(64)    NOT NULL,
    [Description]   NVARCHAR(255)   NOT NULL,
    Priority        INT             NOT NULL    DEFAULT(0),	
    DateAdded		DATETIME        NOT NULL	DEFAULT(GETDATE())
);


INSERT INTO tblRoles (Id, Title, [Description])
VALUES 
(1, 'superadmin', 'SuperAdmin'),
(2, 'admin', 'Admin'),
(3, 'fren', 'Regular User')


CREATE TABLE tblFrens(

    Id				INT PRIMARY KEY,		
    FirstName       NVARCHAR(64)		NOT NULL,
    LastName        NVARCHAR(64),
    UserName        NVARCHAR(64)		NOT NULL    UNIQUE,
    Email           NVARCHAR(255)		NOT NULL    UNIQUE,
    Avatar          NVARCHAR(255),
    [Bio]           NVARCHAR(255),
    DateBorn        NVARCHAR(255)		NOT NULL    DEFAULT(GETDATE()),
	[FrenKey]		UNIQUEIDENTIFIER	NOT NULL	DEFAULT(NEWID()),
    RoleId          INT					NOT NULL    FOREIGN KEY(RoleId)     REFERENCES tblRoles(Id) DEFAULT(3),
    
    DateAdded		DATETIME			NOT NULL	DEFAULT(GETDATE()),
	DateEdited		DATETIME			NOT NULL	DEFAULT(GETDATE()),
    IsActive        BIT					NOT NULL    DEFAULT(1) 
);

CREATE TABLE tblAuthProviders(
	[Id]				INT				PRIMARY KEY,
	[ProviderName]		NVARCHAR(50)	NOT NULL,
	IsActive			BIT				NOT NULL DEFAULT(0)
    );


INSERT INTO tblAuthProviders (Id, ProviderName)
VALUES 
(1, 'Email'),
(2, 'Google'),
(3, 'Facebook'),
(4, 'Twitter');

CREATE TABLE tblFrenLogins(
Id				INT				NOT NULL	PRIMARY KEY,
FrenId			INT				NOT NULL	FOREIGN KEY(FrenId) REFERENCES tblFrens(Id),
AuthProviderId	INT				NOT NULL	FOREIGN KEY(AuthProviderId) REFERENCES tblAuthProviders(Id),
[Uid]			NVARCHAR(255)	NOT NULL,
[Key]			NVARCHAR(255)	NOT NULL,
LastActive		DATETIME		NOT NULL,
IsActive		BIT				NOT NULL DEFAULT(0)			
);