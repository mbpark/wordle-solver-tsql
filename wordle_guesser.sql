drop procedure wordle_guesser
go
create procedure wordle_guesser 
(
@letter1 nvarchar(1),
@letter2 nvarchar(1),
@letter3 nvarchar(1),
@letter4 nvarchar(1),
@letter5 nvarchar(1),
@good_letters nvarchar(26),
@bad_letters nvarchar(26),
@number_of_letters INT
)
AS

BEGIN

CREATE TABLE #goodwords (letters1 nvarchar(50))
DECLARE @loop_counter int


	INSERT INTO #goodwords(letters1)
		select w1.letters1 
			from words_alpha w1
			where 1 = 1
			and datalength(w1.letters1) = @number_of_letters * 2
			AND substring(letters1,1,1) = CASE WHEN @letter1 <> '' THEN @letter1 ELSE substring(letters1,1,1) END
			AND substring(letters1,2,1) = CASE WHEN @letter2 <> '' THEN @letter2 ELSE substring(letters1,2,1) END
			AND substring(letters1,3,1) = CASE WHEN @letter3 <> '' THEN @letter3 ELSE substring(letters1,3,1) END
			AND substring(letters1,4,1) = CASE WHEN @letter4 <> '' THEN @letter4 ELSE substring(letters1,4,1) END
			AND substring(letters1,5,1) = CASE WHEN @letter5 <> '' THEN @letter5 ELSE substring(letters1,5,1) END

SET @loop_counter = 1

WHILE @loop_counter <= LEN(@bad_letters)
BEGIN
	SELECT @loop_counter,substring(@bad_letters,@loop_counter,1)
	DELETE #goodwords WHERE letters1 LIKE '%'+substring(@bad_letters,@loop_counter,1)+'%'
	SET @loop_counter = @loop_counter + 1
END

SET @loop_counter = 1

WHILE @loop_counter <= LEN(@good_letters)
BEGIN
	DELETE #goodwords WHERE letters1 NOT LIKE '%'+substring(@good_letters,@loop_counter,1)+'%'
	SET @loop_counter = @loop_counter + 1
END

select * from #goodwords
WHERE 1 = 1


END
go
