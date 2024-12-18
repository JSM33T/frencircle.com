CREATE PROCEDURE sproc_AddMessage
    @UserId INT,
    @Message NVARCHAR(255),
    @Origin NVARCHAR(255) = 'na', -- Default value
    @DbResult INT OUTPUT -- Output parameter
AS
BEGIN
    SET NOCOUNT ON;
	

	 IF EXISTS (
        SELECT 1 
        FROM tblMessages 
        WHERE UserId = @UserId AND Message = @Message
    )
    BEGIN
        SELECT @DbResult = 1; 
        RETURN;
    END


    DECLARE @NewId INT;
    -- Calculate the new Id as MAX(Id) + 1
    SELECT @NewId = ISNULL(MAX(Id), 0) + 1 FROM tblMessages;

    -- Insert the new message
    INSERT INTO tblMessages (Id, UserId, Message, Origin, DateAdded, IsRead)
    VALUES (@NewId, @UserId, @Message, @Origin, GETDATE(), 0);


	SELECT @DbResult = 0
END;


--	DECLARE @DbResult INT;

--	EXEC sproc_AddMessage 
--		@UserId = 1,
--		@Message = 'This is a sdfsdtest message!',
--		@Origin = 'web',
--		@DbResult = @DbResult OUTPUT;
--		PRINT @DbResult

--	IF @DbResult = 1
--			PRINT 'Message already exists!';
--	ELSE
--			PRINT 'Message added successfully!';
