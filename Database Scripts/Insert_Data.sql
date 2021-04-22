If Not Exists(Select * From Erp.TBPermission Where Permission = 'View_Product')
	Insert Into Erp.TBPermission(Permission)
	Values('View_Product'),('Edit_Product')
Go
If Not Exists(Select * From Erp.TBGroup)
	Insert Into Erp.TBGroup(ID,[Name],Active)
	Values(1, 'Administrators', 1)
Go
If Not Exists(Select * From Erp.TBUsers)
	Insert Into Erp.TBUsers(ID,[Name],Family,Mobile,Email,Token,TokenTime,LastLogin,Active)
	Values(1, 'Arman', 'Zahmatkesh', '5349268654', 'info@Zahmatkesh.dev', NEWID(),GetDate(),GETDATE(),1)
Go
If Not Exists(Select * From Erp.TBGroup_Users)
	Insert Into Erp.TBGroup_Users(GrpID,UserID,EDate)
	Values(1, 1, GETDATE())
Go
Insert Into Erp.TBGroup_Permission(GrpID,PermissionID,EDate)
	Select 1, A.ID, GetDate()
	From Erp.TBPermission A
		Left Outer Join Erp.TBGroup_Permission B On A.ID = B.PermissionID And B.GrpID = 1
	Where B.GrpID Is Null
