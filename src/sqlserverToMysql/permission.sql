if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[company]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[company]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[companyrelation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[companyrelation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[department]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[department]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[departmentrelation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[departmentrelation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[functionandrole]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[functionandrole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[functionn]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[functionn]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[log]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[role]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[role]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[userandrole]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[userandrole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[users]
GO


CREATE TABLE [dbo].[company] (
	[companyId] [int] IDENTITY (1, 1) NOT NULL ,
	[companyName] [varchar] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[company_p] [int] NULL ,
	[companyAddress] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[companyPhone] [varchar] (15) COLLATE Chinese_PRC_CI_AS NULL ,
	[companyAuthority] [varchar] (15) COLLATE Chinese_PRC_CI_AS NULL ,
	[companyNet] [varchar] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[companyState] [int] NULL ,
	[companyType] [varchar] (5) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[companyrelation] (
	[company_p] [int] NOT NULL ,
	[company_s] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[department] (
	[departmentId] [int] IDENTITY (1, 1) NOT NULL ,
	[departmentName] [varchar] (16) COLLATE Chinese_PRC_CI_AS NULL ,
	[department_p] [int] NULL ,
	[companyId] [int] NULL ,
	[departmentPhone] [varchar] (5) COLLATE Chinese_PRC_CI_AS NULL ,
	[departmentAuthority] [varchar] (5) COLLATE Chinese_PRC_CI_AS NULL ,
	[departmentState] [int] NULL ,
	[departmentType] [varchar] (5) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[departmentrelation] (
	[department_p] [int] NOT NULL ,
	[department_s] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[functionandrole] (
	[roleId] [int] NOT NULL ,
	[functionId] [int] NULL ,
	[functionName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[functionn] (
	[functionId] [int] IDENTITY (1, 1) NOT NULL ,
	[functionName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[url] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[log] (
	[logId] [int] IDENTITY (1, 1) NOT NULL ,
	[operator] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[url] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[ipAddress] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[actionName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[logDate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[role] (
	[roleId] [int] IDENTITY (1, 1) NOT NULL ,
	[roleName] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[roleNumber] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[userandrole] (
	[userId] [int] NOT NULL ,
	[roleId] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[users] (
	[userId] [int] IDENTITY (1, 1) NOT NULL ,
	[userName] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[userPassWord] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[sex] [varchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[duty] [varchar] (7) COLLATE Chinese_PRC_CI_AS NULL ,
	[Email] [varchar] (17) COLLATE Chinese_PRC_CI_AS NULL ,
	[companyId] [int] NULL ,
	[departmentId] [int] NULL ,
	[Mk] [int] NULL ,
	[userState] [int] NULL 
) ON [PRIMARY]
GO


/*初始化数据
insert  into company(companyId,companyName,company_p,companyAddress,companyPhone,companyAuthority,companyNet,companyState,companyType) values (1,'海恒',0,'交大','029-','0','',1,'');
insert  into department(departmentId,departmentName,department_p,companyId,departmentPhone,departmentAuthority,departmentState,departmentType) values (1,'开发',0,'1','','0',1,'');

insert  into role(roleId,roleName,roleNumber) values (1,'系统管理员',1);
insert  into role(roleId,roleName,roleNumber) values (2,'单位管理员',2);
insert  into users(userId,userName,userPassWord,sex,duty,Email,companyId,departmentId,Mk,userState) 
values (1,'seavision','seavision','1','管理员','hr@seavision.com.cn',1,1,1,1);*/

/*初始化数据*/
insert  into company(companyName,company_p,companyAddress,companyPhone,companyAuthority,companyNet,companyState,companyType) values ('海恒',0,'交大','029-','0','',1,'');
insert  into department(departmentName,department_p,companyId,departmentPhone,departmentAuthority,departmentState,departmentType) values ('开发',0,'1','','0',1,'');

insert  into role(roleName,roleNumber) values ('系统管理员',1);
insert  into role(roleName,roleNumber) values ('单位管理员',2);
insert  into users(userName,userPassWord,sex,duty,Email,companyId,departmentId,Mk,userState) values ('seavision','seavision','1','管理员','',1,1,1,1);



