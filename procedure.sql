CREATE TABLE Student(
s_id      INTEGER PRIMARY KEY,
sname     VARCHAR(50),

);
INSERT INTO Student (s_id, sname)
VALUES
(56, 'ali'),
(59, 'khawla'),
(62, 'lamar'),
(71, 'omar'),
(78, 'saeed'),
(82, 'majid'),
(85, 'anod'),
(87, 'qadir'),
(90, 'mansor'),
(101, 'mazin'),
(102, 'alia'),
(106, 'zwinah');

--Write a procedure which displays all even numbers below 100.
CREATE PROCEDURE SelectAlleven 
AS
begin

SELECT *
FROM student 
where S_id % 2 = 0 and s_id <100; 
end;
EXEC SelectAlleven
--• Write a procedure which displays all odd numbers below 100.
CREATE PROCEDURE SelectAllodd
AS
begin

SELECT *
FROM student 
where S_id % 2 <> 0 and s_id <100; 
end;
EXEC SelectAllodd
--• Write a procedure which display whether  a number  is prime or 
--not.
CREATE PROCEDURE check_student_id_prime(@s_id INT)
AS
BEGIN
    DECLARE @is_prime INT = 1;
    DECLARE @i INT = 2;

    WHILE @i <= FLOOR(SQRT(@s_id)) BEGIN
        IF @s_id % @i = 0 BEGIN
            SET @is_prime = 0;
            BREAK;
        END;
        SET @i = @i + 1;
    END;
    
    IF @s_id < 2 BEGIN
        SET @is_prime = 0;
    END;

    IF @is_prime = 1 BEGIN
        PRINT @s_id + ' is prime';
    END
    ELSE BEGIN
        PRINT @s_id + ' is not prime';
    END;
END;
EXEC check_student_id_prime (56);

--• Write a procedure which display the sum of 10 numbers.
CREATE PROCEDURE Sum_10
AS
BEGIN
    SELECT SUM(s_id) AS Sum_id
    FROM (
        SELECT TOP 10 s_id
        FROM Student
        ORDER BY s_id
    ) AS First_10_Records
END

exec Sum_10
--• Write a procedure which display 20 multiples for all the numbers between  2 given numbers.
CREATE PROCEDURE Multiples_20 (@num1 int, @num2 int)
AS
BEGIN
    DECLARE @i int = @num1
    
    WHILE (@i <= @num2) BEGIN
        PRINT 'Multiples of ' + CAST(@i AS VARCHAR(10)) + ':'
        DECLARE @j int = 1
        WHILE (@j <= 20) BEGIN
            PRINT CAST(@i * @j AS VARCHAR(10))
            SET @j = @j + 1
        END
        SET @i = @i + 1
    END
END
EXEC Multiples_20 3, 4

--• Write a procedure to display the reverse of a given number.
CREATE PROCEDURE ReverseNumber
  @inputNumber int
AS
BEGIN
  DECLARE @reverseNumber int = 0, @remainder int

  WHILE (@inputNumber > 0)
  BEGIN
    SET @remainder = @inputNumber % 10
    SET @reverseNumber = (@reverseNumber * 10) + @remainder
    SET @inputNumber = @inputNumber / 10
  END

  SELECT @reverseNumber AS 'Reverse Number'
END
EXEC ReverseNumber 12345

--• Write a procedure to display the sum of individual digits of given 
--number.
CREATE PROCEDURE SumOfDigits
  @inputNumber int
AS
BEGIN
  DECLARE @sum int = 0, @digit int

  WHILE (@inputNumber > 0)
  BEGIN
    SET @digit = @inputNumber % 10
    SET @sum = @sum + @digit
    SET @inputNumber = @inputNumber / 10
  END

  SELECT @sum AS 'Sum of Digits'
END
EXEC SumOfDigits 984
