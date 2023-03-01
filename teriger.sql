
CREATE TABLE Registration (
    AcNo INTEGER PRIMARY KEY,
    Fname VARCHAR(15)  NOT NULL,
    Lname VARCHAR(15)  NOT NULL,
    DOB DATE,
    RegDate DATE DEFAULT CONVERT(DATE, GETDATE()),
    CivilId INTEGER  NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('m', 'M', 'f', 'F')),
    GSM VARCHAR(8) UNIQUE CHECK (GSM LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    Openbal INTEGER CHECK (Openbal >= 50)
	);
CREATE TABLE Deposits (
    DNo INT PRIMARY KEY,
    AcNo int FOREIGN KEY REFERENCES Registration(AcNo),
    DDate DATE DEFAULT GETDATE(),
    DAmount INT NOT NULL,
    DLocation VARCHAR(10) NOT NULL
);
CREATE TABLE Withdrawals (
    WNo int PRIMARY KEY,
    AcNo int FOREIGN KEY REFERENCES Registration(AcNo),
    WDate DATE DEFAULT GETDATE(),
    WAmount int NOT NULL,
    WLocation VARCHAR(10) NOT NULL
);

CREATE PROCEDURE Reg_Add_Record
    @AcNo INT,
    @FName VARCHAR(15),
    @LName VARCHAR(15),
    @DOB DATE,
    @CivilID INT,
    @Gender CHAR(1),
    @GSM VARCHAR(8),
    @OpenBal INT
AS
BEGIN
    DECLARE @RegDate DATE = CONVERT(DATE, GETDATE());
    
    IF EXISTS(SELECT * FROM Registration WHERE AcNo = @AcNo)
    BEGIN
        PRINT 'Not done';
    END
    ELSE
    BEGIN
        IF @OpenBal < 50
        BEGIN
            PRINT 'Not done';
        END
        ELSE
        BEGIN
            INSERT INTO Registration (AcNo, FName, LName, DOB, RegDate, CivilID, Gender, GSM, OpenBal)
            VALUES (@AcNo, @FName, @LName, @DOB, @RegDate, @CivilID, @Gender, @GSM, @OpenBal);
            PRINT 'Done';
        END
    END
END;

EXECUTE Reg_Add_Record 1002, 'mazin', 'qasmi', '1990-01-01', 118579, 'M', '71033443', 9600

CREATE PROCEDURE Reg_Update_OpenGSM
    @AcNo INT,
    @newGSM VARCHAR(8)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Registration
    SET GSM = @newGSM
    WHERE AcNo = @AcNo ;
	
END
EXEC Reg_Update_OpenGSM 1001, '96959305';

CREATE PROCEDURE Reg_Del_Record
    @AcNo INT
  
AS
BEGIN
    SET NOCOUNT ON;
    DELETE Registration
    WHERE AcNo = @AcNo ;
	
END 
EXEC Reg_Del_Record 1001
CREATE PROCEDURE Deposit_Amt
    @DNo int,
    @AcNo int,
    @DAmount int,
    @DLocation varchar(10)
AS
BEGIN
DECLARE @DDate DATE = CONVERT(DATE, GETDATE());
    INSERT INTO Deposits (DNo, AcNo, DDate, DAmount, DLocation)
    VALUES (@DNo, @AcNo, @DDate, @DAmount, @DLocation);
END;
EXEC Deposit_Amt @DNo = 10, @AcNo = 1001, @DAmount = 500, @DLocation = 'ATM A130'
CREATE PROCEDURE Withdraw_Amt
    @WNo int,
    @AcNo int,
    @WAmount int,
    @WLocation varchar(10)
AS
BEGIN
DECLARE @WDate DATE = CONVERT(DATE, GETDATE());
    SET NOCOUNT ON;
    INSERT INTO Withdrawals (WNo, AcNo, WDate, WAmount, WLocation)
    VALUES (@WNo, @AcNo, @WDate, @WAmount, @WLocation);
END;
EXEC Withdraw_Amt @WNo = 12, @AcNo = 1001, @WAmount = 150, @WLocation = 'ATM/CDM A130';
-----------------------------
----------------------------------------------
--1. Create a trigger (Trigger_Deposit_Bal_Update) on Deposits table to update OpenBal in Registration table, whenever a person deposits money in the account. 

CREATE TRIGGER Trigger_Deposit_Bal_Update
ON Deposits
AFTER INSERT
AS
BEGIN
  UPDATE Registration
  SET Openbal = Openbal + inserted.DAmount
  FROM Registration
  INNER JOIN inserted
  ON Registration.AcNo = inserted.AcNo;
END;
EXEC Deposit_Amt @DNo = 20, @AcNo = 1002, @DAmount = 500, @DLocation = 'ATM A138'
--2. Create a trigger (Trigger_Withdrawls_Bal_Update) on Withdrawls table to update OpenBal in Registration table, whenever a person withdraws money from the account. 
--Make sure to perform OpenBal check before he withdraws money. WAmount should be less than OpenBal 


CREATE TRIGGER Trigger_Withdrawals_Bal_Update
ON Withdrawals
AFTER INSERT
AS
BEGIN
  UPDATE Registration
  SET Openbal = Openbal - inserted.WAmount
  FROM Registration
  INNER JOIN inserted
  ON Registration.AcNo = inserted.AcNo
  WHERE inserted.WAmount <= Openbal
    AND Openbal - inserted.WAmount >= 0;
  IF @@ROWCOUNT > 0
    PRINT 'Money withdrawal successful. Thank you for using our bank.';
  ELSE
    PRINT 'Sorry, not enough money in your account.';
END;
EXEC Withdraw_Amt @WNo = 17, @AcNo = 1002, @WAmount = 3500, @WLocation = 'ATM/CDM A139';