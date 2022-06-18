--UC1 Create Database Addressbook --
create database AddressBook

use AddressBook 

create table Addressbook
(
Id int Primary Key Identity (1,1),
FirstName VarChar (200),
LastName varchar(150),
Address varchar(250),
City varchar(25),
State varchar(60),
ZipCode int,
PhoneNumber Varchar(10),
Email varchar(150)
);

--UC3 insert data in Address book--
Insert into AddressBook Values ('Rajesh','yadav','Bemetara','Durg','Chhattisgarh',490022,'7898625487','Mohan321@gmail.com'),
('Pukesh','yadav','Berla','Durg','Chhattisgarh',542154,'8952241265','rajd99@gmail.com'),
('murali','Upadhyay','gondiya','mumbai','Maharastra',675438,'8757889475','mural001@gmail.com'),
('komal','patil','saibaba nagar','surat','gujarat',34567,'7854216785','komal222@gmail.com'),
('riya','khairnar','shiv nagar','jaipur','Rajasthan',432007,'7285108928','riya8993@gmail.com');

select * from AddressBook

--UC4--
Update Addressbook Set City='Banglore',State='karnatak' where FirstName='Rajesh';
Update Addressbook Set Address='bhilai',ZipCode='491335' where FirstName='Pukesh';
select * from AddressBook

--UC5--
Delete from Addressbook where FirstName='riya';
select * from Addressbook

--UC6--
Select * from Addressbook where City='mumbai' Order By FirstName;
Select * from AddressBook where State='Maharastra' Order By FirstName;

--UC7--
select count(*) from AddressBook where city='Durg';

select count(*) from AddressBook where State='Maharastra';

--UC8--
select FirstName from Addressbook Order By City ASC;
select FirstName,LastName,City from Addressbook Order By City DESC;
select city from Addressbook order by LastName;

--UC9--
 alter table Addressbook ADD Type varchar (10);
 select * from Addressbook
  update AddressBook SET Type ='Family' Where FirstName = 'Pukesh';
update AddressBook SET Type = 'Profession' Where FirstName='murali';
update AddressBook SET Type = 'friends' Where FirstName='Rajesh';

 --UC10--
 select count(*),Type from Addressbook group by Type;

 --UC11--
 alter table Addressbook Drop column Type;

Select* from Addressbook;

Create table AddressBookType( TypeId int NOT NULL Primary Key  Identity(1,1),Type varchar(25), );


Create table AddressBookMapping( MappingID int primary key Identity (1,1),
AddressBookID int,
Typeid int,
);

alter table AddressBookMapping ADD Foreign key (AddressBookID) References AddressBook(Id);
alter table AddressBookMapping ADD Foreign key (Typeid) References AddressBookType(Typeid);

select * from AddressBookType;
select * from AddressBookMapping;

Insert into AddressBookType values('Friends'),('Family'),('Profession'),('others');

Insert into AddressBookMapping(AddressBookID,Typeid)values(1,1),(1,2);

select * from Addressbook INNER JOIN AddressBookMapping ON AddressBookID=AddressBookMapping.AddressBookID INNER JOIN AddressBookType ON AddressBookType.Typeid=AddressBookMapping.Typeid



-------------------------------

use [AddressBook]


CREATE PROCEDURE [dbo].[InsertAddressdata]
(
	@ID int,
	@FirstName varchar(15),
	@LastName varchar(15),
	@Address varchar(50),
	@City varchar(15),
	@State varchar(30),
	@ZipCode Bigint,
	@PhoneNumber Bigint,
	@Email varchar(50)
	)
	
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	SET NOCOUNT ON;
	DECLARE @new_identity INTEGER = 0;
	DECLARE @result bit = 0;
	INSERT INTO Addressbook(FirstName, LastName, Address, City, State, ZipCode, PhoneNumber, Email)
	VALUES ('mohan', 'sahu', 'bemetara', 'durg', 'cg', 490020, 7898625484, 'sahu12@gmail.com')
	SELECT @new_identity = @@IDENTITY;
	COMMIT TRANSACTION
	SET @result = 1;
	RETURN @result;
	END TRY
	BEGIN CATCH

	IF(XACT_STATE()) = -1
		BEGIN
		PRINT
		'Transaction is uncommitable' + ' Rolling back transaction'
		ROLLBACK TRANSACTION;
		RETURN @result;		
		END
	ELSE IF(XACT_STATE()) = 1
		BEGIN
		PRINT
		'Transaction is commitable' + ' Commiting back transaction'
		COMMIT TRANSACTION;
		SET @result = 1;
	    RETURN @result;
	END;
	END CATCH
END
GO


select * from Addressbook

--select--
CREATE PROCEDURE [dbo].[SelectData]
(
	@Id int,
	@FirstName varchar(15),
	@LastName varchar(15),
	@Address varchar(50),
	@City varchar(15),
	@State varchar(30),
	@ZipCode Bigint,
	@PhoneNumber Bigint,
	@Email varchar(50)
	)
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	SET NOCOUNT ON;
	DECLARE @result bit = 0;
	select * from Addressbook
	COMMIT TRANSACTION
	SET @result = 1;
	RETURN @result;
	END TRY
	BEGIN CATCH

	IF(XACT_STATE()) = -1
		BEGIN
		PRINT
		'Transaction is uncommitable' + ' Rolling back transaction'
		ROLLBACK TRANSACTION;
		RETURN @result;		
		END
	ELSE IF(XACT_STATE()) = 1
		BEGIN
		PRINT
		'Transaction is commitable' + ' Commiting back transaction'
		COMMIT TRANSACTION;
		SET @result = 1;
	    RETURN @result;
	END;
	END CATCH
END
GO


--Update--





CREATE PROCEDURE [dbo].[UpdateData]
(
	@Id int,  
   @Type varchar (50)  
   	)
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	SET NOCOUNT ON;
	DECLARE @result bit = 0;
	  Update Addressbook set Type = @type
   where Id=@Id  
	COMMIT TRANSACTION
	SET @result = 1;
	RETURN @result;
	END TRY
	BEGIN CATCH

	IF(XACT_STATE()) = -1
		BEGIN
		PRINT
		'Transaction is uncommitable' + ' Rolling back transaction'
		ROLLBACK TRANSACTION;
		RETURN @result;		
		END
	ELSE IF(XACT_STATE()) = 1
		BEGIN
		PRINT
		'Transaction is commitable' + ' Commiting back transaction'
		COMMIT TRANSACTION;
		SET @result = 1;
	    RETURN @result;
	END;
	END CATCH
END
GO

--Delete--
CREATE PROCEDURE [dbo].[DeleteData]
(
	@Id int
	)
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	SET NOCOUNT ON;
	DECLARE @result bit = 0;
	  Delete from Addressbook where Id=@Id  
	COMMIT TRANSACTION
	SET @result = 1;
	RETURN @result;
	END TRY
	BEGIN CATCH

	IF(XACT_STATE()) = -1
		BEGIN
		PRINT
		'Transaction is uncommitable' + ' Rolling back transaction'
		ROLLBACK TRANSACTION;
		RETURN @result;		
		END
	ELSE IF(XACT_STATE()) = 1
		BEGIN
		PRINT
		'Transaction is commitable' + ' Commiting back transaction'
		COMMIT TRANSACTION;
		SET @result = 1;
	    RETURN @result;
	END;
	END CATCH
END
GO

