Drop Procedure If Exists Erp.PrcCreate_CRUID
Go
Create Procedure Erp.PrcCreate_CRUID @Schema NVarchar(10), @TBName NVarChar(100), @SPermission NVarChar(100), @UPermission NVarChar(100)
With Encryption
As
Begin
-- Exec Erp.PrcCreate_CRUID @Schema='Inv', @TBName='TBProduct', @SPermission='View_Product', @UPermission = 'Edit_Product'


	Declare @FieldName NVarChar(100), @Type Int, @TypeName NVarChar(100), 
		@PKUpdate NVarChar(max), 
		@DelPKField NVarChar(max), 
		@SFld NVarChar(max), 
		@UFld NVarChar(max), 
		@DeclareFields NVarChar(max), 
		@InsertFld NVarChar(max)
	Declare @Res Table(note NVarChar(max))


	Declare CrsPk Cursor For
		Select b.name
		From Sys.sysindexkeys a
			inner join sys.syscolumns b on a.id = b.id and a.colid=b.colid
		Where a.id = Object_ID(@Schema+'.'+@TBName)

	Open CrsPK
	Fetch Next From CrsPK Into @fieldName

	While @@FETCH_STATUS = 0
	Begin
		if @PKUpdate is Null
			Set @PKUpdate = @FieldName+' = @'+@FieldName
		else
			Set @PKUpdate = @PKUpdate+', '+@FieldName+' = @'+@FieldName
		if @DelPKField is Null
			Set @DelPKField = '@'+@FieldName+' Int'
		else
			Set @DelPKField = @DelPKField+', '+'@'+@FieldName+' Int'
		Fetch Next From CrsPK Into @fieldName
	End
	Close CrsPK
	DeAllocate CrsPK

	Declare Crs Cursor For
		Select A.name, A.system_type_id, B.[name]
		From sys.dm_exec_describe_first_result_set('Select * From '+@Schema+'.'+@TBName, null, 0) a
			Inner Join Sys.systypes B On A.system_type_id = B.xusertype

	--62 = float, 56 = int, 231 = nvarchar

	Open Crs
	Fetch Next From Crs Into @fieldName, @Type, @TypeName

	While @@FETCH_STATUS = 0
	Begin
		if @SFld Is Null
		Begin
			Set @SFld = '['+@FieldName+']'
			Set @InsertFld = '@'+@FieldName
			Set @UFld = @FieldName+' = @'+@FieldName
			Set @DeclareFields = '@'+@FieldName+' '+@TypeName
			if @type = 231
				Set @DeclareFields = @DeclareFields+'(max)'
		End
		Else
		Begin
			Set @SFld = @SFld+', '+'['+@FieldName+']'
			Set @InsertFld = @InsertFld+', @'+@FieldName
			Set @UFld = @UFld+', '+@FieldName+' = @'+@FieldName
			Set @DeclareFields = @DeclareFields+', @'+@FieldName+' '+@TypeName
			if @type = 231
				Set @DeclareFields = @DeclareFields+'(max)'
		End

		Fetch Next From Crs Into @fieldName, @Type, @TypeName
	End
	Close Crs
	DeAllocate Crs

	Insert Into @Res Select 'Drop Procedure If Exists '+@Schema+'.PrcView_'+REPLACE(@TBName, 'TB', '')
	Insert Into @Res Select 'Go'
	Insert Into @Res Select 'Create Procedure '+@Schema+'.PrcView_'+REPLACE(@TBName, 'TB', '')+' @Token UniqueIdentifier, @IP NVarChar(50), @Browser NVarChar(max)'
	Insert Into @Res Select 'With Encryption'
	Insert Into @Res Select 'As'
	Insert Into @Res Select 'Begin'
	Insert Into @Res Select '	if Not Exists(Select * From Erp.TBUsers Where Token=@Token And TokenTime+3 >= GetDate() And IsNull(Active, 0) = 1)'
	Insert Into @Res Select '		Throw 50000, ''You session expired, please login again'', 1'
	Insert Into @Res Select '	if Not Exists(Select * From Erp.FnUserPermission(@Token, '''+@SPermission+'''))'
	Insert Into @Res Select '		Throw 50001, ''You dont have permission'', 1'
	Insert Into @Res Select '	Select '+@SFld
	Insert Into @Res Select '	From '+@Schema+'.'+@TBName
	Insert Into @Res Select 'End'
	Insert Into @Res Select 'Go'
	Insert Into @Res Select 'Grant Execute On '+@Schema+'.PrcView_'+REPLACE(@TBName, 'TB', '')+' To WebApi'
	Insert Into @Res Select 'Go'


	Insert Into @Res Select 'Drop Procedure If Exists '+@Schema+'.PrcSave_'+REPLACE(@TBName, 'TB', '')
	Insert Into @Res Select 'Go'
	Insert Into @Res Select 'Create Procedure '+@Schema+'.PrcSave_'+REPLACE(@TBName, 'TB', '')+' @Token UniqueIdentifier, @IP NVarChar(50), @Browser NVarChar(max), '+@DeclareFields
	Insert Into @Res Select 'With Encryption'
	Insert Into @Res Select 'As'
	Insert Into @Res Select 'Begin'
	Insert Into @Res Select '	if Not Exists(Select * From Erp.TBUsers Where Token=@Token And TokenTime+3 >= GetDate() And IsNull(Active, 0) = 1)'
	Insert Into @Res Select '		Throw 50000, ''You session expired, please login again'', 1'
	Insert Into @Res Select '	if Not Exists(Select * From Erp.FnUserPermission(@Token, '''+@UPermission+'''))'
	Insert Into @Res Select '		Throw 50001, ''You dont have permission'', 1'
	Insert Into @Res Select '	if Exists(Select * From '+@Schema+'.'+@TBName+' Where '+@PKUpdate+')'
	Insert Into @Res Select '		Update '+@schema+'.'+@TBName
	Insert Into @Res Select '		Set '+@UFld
	Insert Into @Res Select '		OutPut '+@InsertFld
	Insert Into @Res Select '		Where '+@PKUpdate
	Insert Into @Res Select '	Else '
	Insert Into @Res Select '		Insert Into '+@schema+'.'+@TBName+'('+@SFld+')'
	Insert Into @Res Select '		OutPut '+@InsertFld
	Insert Into @Res Select '		Values('+@InsertFld+')'
	Insert Into @Res Select 'End'
	Insert Into @Res Select 'Go'
	Insert Into @Res Select 'Grant Execute On '+@Schema+'.PrcSave_'+REPLACE(@TBName, 'TB', '')+' To WebApi'
	Insert Into @Res Select 'Go'


	Insert Into @Res Select 'Drop Procedure If Exists '+@Schema+'.PrcDel_'+REPLACE(@TBName, 'TB', '')
	Insert Into @Res Select 'Go'
	Insert Into @Res Select 'Create Procedure '+@Schema+'.PrcDel_'+REPLACE(@TBName, 'TB', '')+' @Token UniqueIdentifier, @IP NVarChar(50), @Browser NVarChar(max), '+@DelPKField
	Insert Into @Res Select 'With Encryption'
	Insert Into @Res Select 'As'
	Insert Into @Res Select 'Begin'
	Insert Into @Res Select '	if Not Exists(Select * From Erp.TBUsers Where Token=@Token And TokenTime+3 >= GetDate() And IsNull(Active, 0) = 1)'
	Insert Into @Res Select '		Throw 50000, ''You session expired, please login again'', 1'
	Insert Into @Res Select '	if Not Exists(Select * From Erp.FnUserPermission(@Token, '''+@UPermission+'''))'
	Insert Into @Res Select '		Throw 50001, ''You dont have permission'', 1'
	Insert Into @Res Select '	Else '
	Insert Into @Res Select '		Delete '+@schema+'.'+@TBName
	Insert Into @Res Select '		Where '+@PKUpdate
	Insert Into @Res Select 'End'
	Insert Into @Res Select 'Go'
	Insert Into @Res Select 'Grant Execute On '+@Schema+'.PrcDel_'+REPLACE(@TBName, 'TB', '')+' To WebApi'
	Insert Into @Res Select 'Go'

	Select *
	From @Res
End
Go
