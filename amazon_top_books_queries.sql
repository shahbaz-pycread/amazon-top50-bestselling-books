-- Number of records

SELECT COUNT(*) Total_Records
	FROM dbo.topbook;

-- Looking into data

SELECT *
	FROM dbo.topbook;

-- Type of Genre

SELECT DISTINCT Genre
	FROM dbo.topbook;

-- No of books by author (TOP 5)

SELECT TOP 5 Author, COUNT(Name) Total_Books
	FROM dbo.topbook
	GROUP BY Author
	ORDER BY Total_Books DESC;

-- No of books by author By Genre

SELECT Author, COUNT(Name) Total_Books, Genre
	FROM dbo.topbook
	GROUP BY Author, Genre
	ORDER BY Total_Books DESC, Genre;


-- Books  By Genre

SELECT Genre, COUNT(Name) Total_Books
	FROM dbo.topbook
	GROUP BY Genre
	ORDER BY Total_Books DESC;

-- Books By Genre Per Year

WITH total_books_cte AS(
	SELECT COUNT(*) Total_Books, Year, Genre 
	FROM dbo.topbook
	GROUP BY Year, Genre
)
SELECT tbc.[Year], tbc.Genre, tbc.Total_Books
	FROM total_books_cte tbc

-- Highest Rating By Year

SELECT  Name  ,Year,  MAX([User Rating]) Highest_Rating 
	FROM dbo.topbook
	GROUP BY Name, Year
	ORDER BY [Year];

-- Lowest Rating By Year

SELECT Year, MIN([User Rating]) Lowest_Rating
 FROM dbo.topbook
 GROUP BY Year
 ORDER BY [Year];


 -- No of times books were bestselling
 WITH bestselling_cte AS (
	 SELECT   Name, Author,  Year, Genre, 
	 ROW_NUMBER() OVER(PARTITION BY Name ORDER BY Year) rn
	 FROM dbo.topbook
 )
 SELECT TOP 5 Name, Author,  Genre, COUNT(rn) Total_times
	FROM bestselling_cte
	WHERE rn >= 1
	GROUP BY Name, Author, Genre
	ORDER BY Total_times DESC;

-- Maximum number of Reviews

SELECT TOP 5 Name, MAX(Reviews) Total_Reviews
	FROM dbo.topbook
	GROUP BY Name
	ORDER BY Total_Reviews DESC;



-- Highest Price

SELECT TOP 1 Name, Author, Year, Genre, MAX(Price) Price
	FROM dbo.topbook
	GROUP BY Name, Author, Year, Genre
	ORDER BY Price DESC;

-- Lowest Price

SELECT TOP 1 Name, Author, Year, Genre, MIN(Price) Price
	FROM dbo.topbook
	GROUP BY Name, Author, Year, Genre
	ORDER BY Price ;

-- Average Price Per Genre

SELECT  Genre, ROUND(AVG(Price),2) Price
	FROM dbo.topbook
	GROUP BY  Genre;

-- Highest Price Per Genre

SELECT TOP 2 Genre, MAX(Price) Price
	FROM dbo.topbook
	GROUP BY  Genre
	ORDER BY Price DESC;

-- Lowest Price Per Genre

SELECT TOP 2 Genre, MIN(Price) Price
	FROM dbo.topbook
	GROUP BY  Genre
	ORDER BY Price;

SELECT Genre, [User Rating], COUNT([User Rating]) Rating
	FROM dbo.topbook
	GROUP BY Genre, [User Rating]
	ORDER BY Rating DESC;