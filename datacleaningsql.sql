SELECT *
FROM movies
--Cleaning year column--
UPDATE movies
SET year = REPLACE(year, '(', '');

UPDATE movies
SET year = REPLACE(year, ')', '');
--to remove the brackets--

UPDATE movies
SET year = REPLACE(year, '|', '');

UPDATE movies
SET year = BTRIM(year);

UPDATE movies
SET year = REPLACE(year, 'I', '');

DELETE FROM movies
WHERE year = 'Video';

DELETE FROM movies
WHERE year in ('V','XL','XX','X'); 

UPDATE movies
SET year = REPLACE(year, 'V', '');

DELETE FROM movies
WHERE year like '%T%';

UPDATE movies
SET year = REPLACE(year, 'ideo', '');

--cleaning gentre column --
UPDATE movies
SET genre = LTRIM(genre);

UPDATE movies
SET genre = regexp_replace (genre, E'[\\n\\r]+', '', 'g');

SELECT DISTINCT (genre)
FROM movies;

--cleaning votes cloumn--
SELECT DISTINCT (votes)
FROM movies

--removing comma from votes column--
UPDATE movies
SET votes = REPLACE(votes, ',', '');

--casting votes column to integer--
ALTER TABLE movies
ALTER COLUMN votes
TYPE integer
USING votes :: integer;

--cleaning gross column--
SELECT DISTINCT (gross)
FROM movies;

--Removing M and changing it to numeric value--
UPDATE movies
SET gross = REPLACE(gross, 'M', '0000');

--removing $ sign and .--
UPDATE movies
SET gross = REPLACE(gross, '$', '');

UPDATE movies
SET gross = REPLACE(gross, '.', '');

--removing the initial 0--
UPDATE movies
SET gross = REPLACE(gross, '0', '')
WHERE gross like '0%';

UPDATE movies
SET gross = NULL
WHERE gross = '';

UPDATE movies
SET gross = 0
WHERE gross IS NULL;

UPDATE movies
SET gross = trim(gross);

--casting gross column to integer-
ALTER TABLE movies
ALTER COLUMN gross TYPE integer
USING gross::integer;
					

--Cleaning one line column--
UPDATE movies
SET one_line = regexp_replace (one_line, E'[\\n\\r]+', '', 'g');

UPDATE movies
SET one_line = ltrim(one_line);

SELECT one_line
FROM movies;

--Cleaning stars column--
UPDATE movies
SET stars = regexp_replace (stars, E'[\\n\\r]+', '', 'g');

UPDATE movies
SET stars = btrim(stars);


--Create director column--
ALTER TABLE movies
ADD COLUMN director TEXT;

--Insert values into director column--
UPDATE movies
SET director = SPLIT_PART (stars, '|',1)
WHERE SPLIT_PART(stars, '|',1) LIKE 'Director%';

--Remove "DIRECTOR"--
UPDATE movies
SET director = SUBSTRING(director FROM position(':' in director)+1 for length (director));

ALTER TABLE movies
ADD column actor TEXT;

--Insert values into actor column--
UPDATE movies
SET actor = SUBSTRING(stars FROM position('|'in stars)+1 for length(stars))
WHERE stars LIKE '%Stars:%' OR  stars LIKE '%Star:%';

--Remove "Star"--
UPDATE movies
SET actor = SUBSTRING(actor FROM position(':' in actor)+1 for length (actor));

--Trim actor column--
UPDATE movies
SET actor = LTRIM(actor);

SELECT DISTINCT (rating)
FROM movies

UPDATE movies
SET rating = trim(rating);

--casting rating column to integer--
ALTER TABLE movies
ALTER COLUMN rating
TYPE decimal USING rating :: decimal;



					

					

					
					
				