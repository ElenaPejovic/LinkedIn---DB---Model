DROP DATABASE IF EXISTS LinkedIn;
USE master;
GO
CREATE DATABASE LinkedIn;
GO
USE LinkedIn; 


DROP DATABASE IF EXISTS [User];
DROP DATABASE IF EXISTS [Profile];
DROP DATABASE IF EXISTS [Experience];
DROP DATABASE IF EXISTS [Education];
DROP DATABASE IF EXISTS [LicenseAndCertification];
DROP DATABASE IF EXISTS [Skill];
DROP DATABASE IF EXISTS [Connection];
DROP DATABASE IF EXISTS [Post];
DROP DATABASE IF EXISTS [Media];
DROP DATABASE IF EXISTS [Comment];
DROP DATABASE IF EXISTS [Reaction];
DROP DATABASE IF EXISTS [ReactionType];
DROP DATABASE IF EXISTS [Repost];


CREATE TABLE [User]
(
	UserId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Email nvarchar(255) NOT NULL, 
	[Password] nvarchar(30) NOT NULL,
	[Name] nvarchar(255) NOT NULL,
	JoinDate date NOT NULL
	
);


CREATE TABLE [Profile]
(
	ProfileId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(20) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	AdditionalName nvarchar(20),
	Headline nvarchar(50) NOT NULL,
	UserId int NOT NULL,
	CONSTRAINT FK_User FOREIGN KEY(UserId) REFERENCES [User](UserId)

);

CREATE TABLE Experience
(	
	ExperienceId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Title nvarchar(30) NOT NULL,
	EmploymentType nvarchar(40),
	[Location] nvarchar(30),
	CompanyName nvarchar(30) NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	Industry nvarchar(30) NOT NULL,
	ProfileId int,
	CONSTRAINT FK_Experience_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId)


);

CREATE TABLE Education
(
	EducationId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	School nvarchar(40) NOT NULL,
	Degree nvarchar(60),
	FieldOfStudy nvarchar(255),
	StartDate date,
	EndDate date,
	Grade decimal(2,2),
	ProfileId int,
	CONSTRAINT FK_Education_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId)

);

CREATE TABLE LicenceAndCertification
(
	LicenceCertificateId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NameOfLicCert nvarchar(40) NOT NULL,
	Organization nvarchar(40) NOT NULL,
	[Date] date,
	[URL] nvarchar(max),
	ProfileId int,
	CONSTRAINT FK_LicAndCert_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId)

);

CREATE TABLE Skill
(
	SkillId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NameOfSkill nvarchar(30) NOT NULL,
	ProfileId int,
	CONSTRAINT FK_Skill_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId)


);


CREATE TABLE Connection
(
	ConnectionId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Conn_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId),
	ConnectionsId int NOT NULL,
	CONSTRAINT FK_ConnectionsId FOREIGN KEY(ConnectionsId) REFERENCES [Profile](ProfileId)


	
);

CREATE TABLE Post
(
	PostId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TextDescription nvarchar(4000),
	PostDate date NOT NULL,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Post_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId)

	
);

CREATE TABLE Media
(
	MediaId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MediaContent nvarchar(max) NOT NULL,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Media_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId),
	PostId int NOT NULL,
	CONSTRAINT FK_Media_Post FOREIGN KEY(PostId) REFERENCES Post(PostId)



);

CREATE TABLE Comment
(
	CommentId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CommentContent nvarchar(500) NOT NULL,
	CommentDate date NOT NULL,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Comment_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId),
	PostId int NOT NULL,
	CONSTRAINT FK_Comment_Post FOREIGN KEY(PostId) REFERENCES Post(PostId)

);

CREATE TABLE ReactionType
(
	ReactionTypeId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ReactionTypeName nvarchar(20) NOT NULL
);

CREATE TABLE Reaction
(
	ReactionId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Reaction_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId),
	PostId int NOT NULL,
	CONSTRAINT FK_Reaction_Post FOREIGN KEY(PostId) REFERENCES Post(PostId),
	ReactionTypeId int NOT NULL,
	CONSTRAINT FK_ReactionType FOREIGN KEY(ReactionTypeId) REFERENCES ReactionType(ReactionTypeId)
);



CREATE TABLE Repost
(
	RepostId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Repost_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId),
	PostId int NOT NULL,
	CONSTRAINT FK_Repost_Post FOREIGN KEY(PostId) REFERENCES Post(PostId)

);

CREATE TABLE Follower
(
	FollowerID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ProfileId int NOT NULL,
	CONSTRAINT FK_Follower_Profile FOREIGN KEY(ProfileId) REFERENCES [Profile](ProfileId),

);