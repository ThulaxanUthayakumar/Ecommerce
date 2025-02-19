USE [ECommerceYT]
GO
/****** Object:  StoredProcedure [dbo].[Category_Crud]    Script Date: 04/11/2024 19:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Category_Crud]
    @Action VARCHAR(15),
    @CategoryId INT = NULL,
    @CategoryName VARCHAR(100) = NULL,
    @CategoryImageUrl VARCHAR(MAX) = NULL,
    @IsActive BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    -- GET ALL CATEGORIES
    IF (@Action = 'GETALL')
    BEGIN
        SELECT * FROM Category;
    END

	   -- GET CATEGORIES By ID
    IF( @Action = 'GETBYID')
    BEGIN
        SELECT * FROM Category WHERE CategoryId = @CategoryId;
    END

    -- INSERT CATEGORY
    ELSE IF (@Action = 'INSERT')
    BEGIN
        INSERT INTO Category (CategoryName, CategoryImageUrl, IsActive, CreatedDate)
        VALUES (@CategoryName, @CategoryImageUrl, @IsActive, GETDATE());
    END

    -- UPDATE CATEGORY
    ELSE IF (@Action = 'UPDATE')
    BEGIN
        IF @CategoryImageUrl IS NULL
        BEGIN
            UPDATE Category
            SET CategoryName = @CategoryName,
                IsActive = @IsActive
            WHERE CategoryId = @CategoryId;
        END
        ELSE
        BEGIN
            UPDATE Category
            SET CategoryName = @CategoryName,
                CategoryImageUrl = @CategoryImageUrl,
                IsActive = @IsActive
            WHERE CategoryId = @CategoryId;
        END
    END

    -- DELETE CATEGORY
    ELSE IF (@Action = 'DELETE')
    BEGIN
        DELETE FROM Category WHERE CategoryId = @CategoryId;
    END

    -- GET ACTIVE CATEGORIES
    ELSE IF (@Action = 'ACTIVECATEGORY')
    BEGIN
        SELECT * FROM Category
        WHERE IsActive = 1
        ORDER BY CategoryName;
    END
END
