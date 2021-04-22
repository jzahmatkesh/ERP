IF Not EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE (name = 'ERP'))
	Create DataBase ERP
Go
If Not Exists(Select * From Sys.syslogins Where [Name] = 'WebApi')
	Create Login WebApi
	With Password = 'P@$$w0rd'
Go
Use ERP
Go
If Not Exists(Select * From Sys.sysusers Where [Name] = 'WebApi')
  Create User WebApi For Login WebApi
Go
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Inv')
	EXEC('CREATE SCHEMA Inv')
Go
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'ERP')
	EXEC('CREATE SCHEMA ERP')
Go
If Object_ID('ERP.TBPermission') Is Null
	Create Table ERP.TBPermission(
		ID Int Primary Key Identity(1,1),
		Permission NVarChar(200),
		Note NVarChar(200)
	)
Go
If Object_ID('ERP.TBGroup') Is Null
	Create Table ERP.TBGroup(
		ID Int Primary Key,
		[Name] NVarChar(200),
		Active BIT
	)
Go
If Object_ID('ERP.TBUsers') Is Null
	Create Table ERP.TBUsers(
		ID Int Primary Key,
		[Name] NVarChar(200),
		[Family] NVarChar(200),
		[Mobile] NVarChar(200),
		[Email] NVarChar(200),
		Token UniqueIdentifier,
		TokenTime DateTime,
		LastLogin DateTime,
		img NVarChar(max),
		Active BIT
	)
Go
If Object_ID('ERP.TBGroup_Users') Is Null
	Create Table ERP.TBGroup_Users(
		GrpID Int Foreign Key References ERP.TBGroup(ID),
		UserID Int Foreign Key References ERP.TBUsers(ID),
		EDate DateTime,
		Primary Key (GrpID,UserID)
	)
Go
If Object_ID('ERP.TBGroup_Permission') Is Null
	Create Table ERP.TBGroup_Permission(
		GrpID Int Foreign Key References ERP.TBGroup(ID),
		PermissionID Int Foreign Key References ERP.TBPermission(ID),
		EDate DateTime,
		Primary Key (GrpID,PermissionID)
	)
Go
If Object_ID('Inv.TBProduct') Is Null
	Create Table Inv.TBProduct(
		ID Int Primary Key,
		[Name] NVarChar(200),
		Price float,
		img NVarChar(max),
		Note NVarChar(max)
	)
Go
if Object_ID('Erp.FnUserPermission') Is Not Null
	Drop Function Erp.FnUserPermission
Go
Drop Function If Exists Erp.FnUserPermission
Go
Create Function Erp.FnUserPermission(@Token UniqueIdentifier, @Permission NVarChar(200))
Returns TABLE 
With Encryption
As
Return
(
	Select D.ID, D.[Name], D.Family
	From Erp.TBGroup_Permission A
		Inner Join Erp.TBPermission B On A.PermissionID = B.ID
		Inner Join Erp.TBGroup_Users C On A.GrpID = C.GrpID
		Inner Join Erp.TBUsers D On C.UserID = D.ID
	Where D.Token = @Token And TokenTime+3 >= GetDate() And B.Permission = @Permission
)
Go