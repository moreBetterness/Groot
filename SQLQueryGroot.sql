use FMIS555ssn6259DB;



Create Table GrootUsers(
	U_ID int IDENTITY(1,1) PRIMARY KEY,
	username nvarchar(30),
	pass nvarchar(30),
	phone nvarchar(20));


Create Table GrootGroups(
	G_ID int IDENTITY(1,1) PRIMARY KEY,
	U_ID int,
	groupName nvarchar(30),
	location nvarchar(30),
	Foreign Key (U_ID) references GrootUsers(U_ID)
)


Create Table GrootDevices(
	D_ID int IDENTITY(1,1) PRIMARY KEY,
	G_ID int,
	geolocation geography,
	Foreign Key (G_ID) references GrootGroups(G_ID)
)


Create Table GrootPH(
	PH_ID int IDENTITY(1,1) PRIMARY KEY,
	D_ID int,
	PH int,
	[timeStamp] timestamp,
	Foreign Key (D_ID) references GrootDevices(D_ID)
)

Create Table GrootMoisture(
	M_ID int IDENTITY(1,1) PRIMARY KEY,
	D_ID int,
	Moist int,
	[timeStamp] timestamp,
	Foreign Key (D_ID) references GrootDevices(D_ID)
	
	)



--Groot User Stored Procedures
	
Create procedure InsertIntoGrootUsers
	@username nvarchar(30),
	@pass nvarchar(30),
	@phone nvarchar(20)
AS

Begin

Set NoCount ON

   IF (@username IS NULL)
   BEGIN
      RAISERROR('invalid value: @username cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@pass IS NULL)
   BEGIN
      RAISERROR('invalid value: @pass cannot be NULL', 16, 1)
      RETURN -1
   END

   IF (@phone IS NULL)
   BEGIN
      RAISERROR('invalid value: @phone cannot be NULL', 16, 1)
      RETURN -1
   END



      BEGIN TRY
      BEGIN TRAN

  Insert into  GrootUsers
		Values(@username, @pass, @phone)

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;




Create procedure UpdateIntoGrootUsers
	@username nvarchar(30),
	@pass nvarchar(30),
	@phone nvarchar(20)

AS

Begin

Set NoCount ON

   IF (@username IS NULL)
   BEGIN
      RAISERROR('invalid value: @username cannot be NULL', 16, 1)
      RETURN -1
   END





      IF (@pass IS NULL)
   BEGIN
      RAISERROR('invalid value: @pass cannot be NULL', 16, 1)
      RETURN -1
   END

   IF (@phone IS NULL)
   BEGIN
      RAISERROR('invalid value: @phone cannot be NULL', 16, 1)
      RETURN -1
   END




      BEGIN TRY
      BEGIN TRAN

  Update GrootUsers
  set pass = @pass

  where username = @username 

  Update GrootUsers
  set  phone = @phone

  where username = @username 




      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;





Create procedure DeleteFromGrootUsers
	@username nvarchar(30),
	@pass nvarchar(30)

AS

Begin

Set NoCount ON

   IF (@username IS NULL)
   BEGIN
      RAISERROR('invalid value: @username cannot be NULL', 16, 1)
      RETURN -1
   END





      IF (@pass IS NULL)
   BEGIN
      RAISERROR('invalid value: @pass cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Delete GrootUsers
    where username = @username  and pass = @pass

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;





--Groot Group Stored Procedures
	
Create procedure InsertIntoGrootGroups
	@U_ID int,
	@groupName nvarchar(30),
	@location nvarchar(30)

AS

Begin

Set NoCount ON

   IF (@U_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @U_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@groupName IS NULL)
   BEGIN
      RAISERROR('invalid value: @groupName cannot be NULL', 16, 1)
      RETURN -1
   END

   IF (@location IS NULL)
   BEGIN
      RAISERROR('invalid value: @location cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Insert into  GrootGroups
		Values(@U_ID, @groupName, @location)

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;




Create procedure UpdateIntoGrootGroups
	@U_ID int,
	@groupName nvarchar(30),
	@location nvarchar(30)

AS

Begin

Set NoCount ON

   IF (@U_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @U_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@groupName IS NULL)
   BEGIN
      RAISERROR('invalid value: @groupName cannot be NULL', 16, 1)
      RETURN -1
   END

   IF (@location IS NULL)
   BEGIN
      RAISERROR('invalid value: @location cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Update GrootGroups
	set location = @location
	where groupName = @groupName and U_ID = @U_ID 

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;





Create procedure DeleteFromGrootGroups
	@U_ID int,
	@groupName nvarchar(30)

AS

Begin

Set NoCount ON

   IF (@U_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @U_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@groupName IS NULL)
   BEGIN
      RAISERROR('invalid value: @groupName cannot be NULL', 16, 1)
      RETURN -1
   END


      BEGIN TRY
      BEGIN TRAN

  Delete GrootGroups
    where U_ID = @U_ID  and groupName = @groupName

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;



--Groot Device Stored Procedures
	
Create procedure InsertIntoGrootDevices
	@G_ID int,
	@geolocation geography

AS

Begin

Set NoCount ON

   IF (@G_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @G_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@geolocation IS NULL)
   BEGIN
      RAISERROR('invalid value: @geolocation cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Insert into  GrootDevices
		Values(@G_ID, @geolocation)

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;




Create procedure UpdateIntoGrootDevices
	@G_ID int,
	@D_ID int,
	@geolocation nvarchar(30)

AS

Begin

Set NoCount ON

   IF (@G_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @G_ID cannot be NULL', 16, 1)
      RETURN -1
   END


   IF (@D_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @D_ID cannot be NULL', 16, 1)
      RETURN -1
   END

	IF (@geolocation IS NULL)
   BEGIN
      RAISERROR('invalid value: @geolocation cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Update GrootDevices
	set geolocation = @geolocation
	where G_ID = @G_ID and D_ID = @D_ID 

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;





Create procedure DeleteFromGrootDevices
	@G_ID int,
	@D_ID int
AS

Begin

Set NoCount ON

   IF (@G_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @G_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@D_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @D_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      BEGIN TRY
      BEGIN TRAN

  Delete GrootDevices
    where G_ID = @G_ID  and D_ID = @D_ID

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;

-- Stored Procedure for PH

Create procedure InsertIntoGrootPH
	@D_ID int,
	@PH int

AS

Begin

Set NoCount ON

   IF (@D_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @D_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@PH IS NULL)
   BEGIN
      RAISERROR('invalid value: @PH cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Insert into  GrootPH(D_ID, PH)
		Values(@D_ID, @PH)

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;




Create procedure DeleteFromGrootPH
	@D_ID int
AS

Begin

Set NoCount ON

   IF (@D_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @G_ID cannot be NULL', 16, 1)
      RETURN -1
   END



      BEGIN TRY
      BEGIN TRAN

  Delete GrootPH
    where D_ID = @D_ID

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;


-- Stored Procedure for Moisture

Create procedure InsertIntoGrootMoisture
	@D_ID int,
	@Moist int

AS

Begin

Set NoCount ON

   IF (@D_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @D_ID cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@Moist IS NULL)
   BEGIN
      RAISERROR('invalid value: @Moist cannot be NULL', 16, 1)
      RETURN -1
   END

      BEGIN TRY
      BEGIN TRAN

  Insert into  GrootMoisture(D_ID, Moist)
		Values(@D_ID, @Moist)

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;

Create procedure DeleteFromGrootMoisture
	@D_ID int
AS

Begin

Set NoCount ON

   IF (@D_ID IS NULL)
   BEGIN
      RAISERROR('invalid value: @D_ID cannot be NULL', 16, 1)
      RETURN -1
   END



      BEGIN TRY
      BEGIN TRAN

  Delete GrootMoisture
    where D_ID = @D_ID

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO;










drop table GrootPlants;

Create Table GrootPlants(
	Pl_ID int IDENTITY(1,1) PRIMARY KEY,
	plantName nvarchar(30),
	PH_Low int,
	PH_High int,
	Moist_Low int,
	Moist_High int
);



insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Blackberry', 5,6,1600,1900);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('BlueBerry', 4,5,1901,2200);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('CranBerry', 4,4,2201,2500);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Parsley', 5,6,2501,2800);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Peanuts', 5,6,2801,3100);

insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Cabbage', 6,7,1600,1900);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Cantaloupe', 6,7,1901,2200);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Cauliflower', 6,7,2201,2500);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Celery', 6,7,2501,2800);
insert into GrootPlants(plantName, PH_Low, PH_High, Moist_Low, Moist_High) values('Chive', 6,7,2801,3100);
