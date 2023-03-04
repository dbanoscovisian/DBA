USE [9D06A]
DECLARE @IncludeFileGroup bit = 1
DECLARE @IncludeDrop bit = 1

BEGIN

 -- Get all existing indexes, but NOT the primary keys

 DECLARE Indexes_cursor CURSOR FOR 
 
 SELECT 
	 Object_name(SI.Object_Id) TableName,
	 SI.Object_Id TableId,
	 SI.[Name] IndexName,
	 SI.Index_ID IndexId,
	 FG.[Name] FileGroupName

 FROM sys.indexes SI
	LEFT JOIN sys.filegroups FG ON SI.data_space_id = FG.data_space_id
 WHERE ObjectProperty(SI.Object_Id, 'IsUserTable') = 1
	 AND SI.[Name] IS NOT NULL
	 AND SI.is_primary_key = 0
	 AND SI.is_unique_constraint = 0
	 AND IndexProperty(SI.Object_Id, SI.[Name], 'IsStatistics') = 0
	 AND LEFT(Object_name(SI.Object_Id),2) <> 'MS' -- remove index replication
 ORDER BY 
	Object_name(SI.Object_Id), SI.Index_ID

 DECLARE @TableName sysname ;
 DECLARE @TableId int ;
 DECLARE @IndexName sysname ;
 DECLARE @FileGroupName sysname ;
 DECLARE @IndexId int ;

 DECLARE @NewLine nvarchar(4000) ;
 DECLARE @tab nvarchar(4000) ;

 SET @NewLine = CHAR(13) + CHAR(10)
 SET @tab = Space(4)

 -- Loop through all indexes

 OPEN 
 Indexes_cursor FETCH NEXT

 FROM Indexes_cursor
 INTO @TableName, @TableId, @IndexName, @IndexId, @FileGroupName

 WHILE (@@Fetch_Status = 0)

	 BEGIN

	 DECLARE @sIndexDesc nvarchar(4000) ;
	 DECLARE @sCreateSql nvarchar(4000) ;
	 DECLARE @sDropSql nvarchar(4000) ;

	 SET @sIndexDesc = '-- Index ' 
						+ @IndexName 
						+ ' on table ' 
						+ @TableName

	 SET @sDropSql = '-- Drop Index ' + @NewLine
						 + 'IF EXISTS(SELECT 1' + @NewLine
						 + ' FROM sysindexes si' + @NewLine
						 + @tab + ' INNER JOIN sysobjects so ON so.id = si.id' + @NewLine
						 + ' WHERE si.[Name] = N''' + @IndexName + ''' -- Index Name' + @NewLine
						 + @tab + ' AND so.[Name] = N''' + @TableName + ''') -- Table Name' + @NewLine
						 + 'BEGIN' + @NewLine
						 + ' DROP INDEX [' + @IndexName + '] ON [' + @TableName + ']' + @NewLine
						 + 'END' + @NewLine


	 -- Loop through all columns of the index and append them to the CREATE statement

	PRINT '-- **********************************************************************'
	PRINT @sIndexDesc
	PRINT '-- **********************************************************************'

	IF @IncludeDrop = 1
		BEGIN
			PRINT @sDropSql
			PRINT 'GO'
		END

	--END IF

	FETCH NEXT
		FROM Indexes_cursor
		INTO @TableName, @TableId, @IndexName, @IndexId, @FileGroupName
	END

	--END WHILE
	CLOSE Indexes_cursor
	DEALLOCATE Indexes_cursor

END

