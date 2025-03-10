CREATE DATABASE WineProduction_DB

-- CREATE TABLE FOR WINE(NumW, Category, Year, Degree)
CREATE TABLE WINE(
NumW INT, 
Category VARCHAR (255) NOT NULL, 
Year INT NOT NULL, 
Degree DECIMAL (4,1),
CONSTRAINT Wine_NumW_PK PRIMARY KEY (NumW)
);

INSERT INTO WINE VALUES 
(1, 'Rose', 2020, 4.0),
(2, 'Red', 1987, 12.0),
(3, 'Sparkling', 2004, 15.0),
(4, 'Dessert', 2022, 14.3),
(5,	'White', 1997, 7.0),
(6, 'Red', 2000, 13.1),
(7, 'Non-Alcoholic', 1880, 0.5),
(8, 'Organic', 1995, 11),
(9, 'Rose', 2009, 12.0),
(10, 'Sparkling', 2022, 25.0),
(11, 'Non-Alcoholic', 2005, 0.0),
(12, 'Rose', 2018, 9.5);


-- CREATE TABLE FOR PRODUCER (NumP, Firstname, Lastname, Region)
CREATE TABLE PRODUCER (
NumP INT, 
Firstname VARCHAR(255) NOT NULL, 
Lastname VARCHAR(255) NOT NULL, 
Region VARCHAR(255) NOT NULL,
CONSTRAINT Prod_NumP_PK PRIMARY KEY (NumP)
);


INSERT INTO PRODUCER VALUES 
(1, 'Jack', 'Daniel', 'Tuscany'),
(2, 'David', 'Pelumi', 'Douro'),
(3, 'Charity', 'Robert', 'Bordeaux'),
(4, 'Leah', 'Troy', 'Napa Valley'),
(5, 'Johnny', 'Walker', 'Sousse'),
(6, 'Sade', 'Ego', 'Napa Valley'),
(7, 'Mason', 'Derulo', 'Sousse'),
(8, 'Peter', 'Doe', 'Tunis'),
(9, 'Marcello', 'Rogers', 'Sousse'),
(10, 'Tommy', 'Varcatti', 'Sfax'),
(11, 'Pedro', 'Diaz', 'Tuscany'),
(12, 'Moyo', 'Gomez', 'Monastir');



-- CREATE TABLE FOR HARVEST (Quantity)
CREATE TABLE HARVEST (
NumW INT NOT NULL,
NumP INT NOT NULL,
Quantity INT NOT NULL,
CONSTRAINT Harvest_NumW_FK FOREIGN KEY (NumW) REFERENCES Wine (NumW) ON DELETE CASCADE,
CONSTRAINT Harvest_NumP_FK FOREIGN KEY (NumP) REFERENCES Producer (NumP) ON DELETE CASCADE
);


INSERT INTO HARVEST VALUES 
(1,1, 550),
(2,2, 150),
(3,3, 450),
(4,4, 200),
(5,5, 100),
(6,6, 315),
(12,7, 230),
(8,8, 430),
(9,9, 250),
(10,10, 135),
(11,11, 440),
(12,12, 340),
(7,1, 450);
 
UPDATE HARVEST SET Quantity = 500 WHERE NumW = 9;

--Retrieve all producers.
SELECT * FROM PRODUCER;

--Retrieve a sorted list of producers by name.
SELECT Firstname, Lastname 
FROM PRODUCER
ORDER BY Firstname, Lastname;

--Retrieve producers from Sousse.
SELECT Firstname, Lastname, Region 
FROM PRODUCER
WHERE Region = 'Sousse';

--Calculate the total quantity of wine produced for Wine Number 12.
SELECT NumW, SUM(Quantity) AS Total_quantity
FROM HARVEST
WHERE NumW = 12
GROUP BY NumW;

--Calculate the total quantity of wine produced for each category.
SELECT w.Category, SUM(Quantity) AS Total_quantity
FROM HARVEST h
JOIN WINE w
ON h.NumW = w.NumW
GROUP BY w.Category;

--Find producers from Sousse who harvested at least one wine in quantities greater than 300 liters.
SELECT P.Firstname, P.Lastname, P.Region, H.Quantity
FROM PRODUCER P
JOIN HARVEST H
ON P.NumP = H.NumP
WHERE P.Region = 'Sousse'
AND H.Quantity > 300;

--List wine numbers with a degree greater than 12, produced by a specific producer.
SELECT W.NumW, P.Firstname, P.Lastname, W.Degree
FROM WINE W
JOIN HARVEST H
ON W.NumW = H.NumW
JOIN PRODUCER P
ON H.NumP = P.NumP
WHERE Degree > 12


--Find the producer who has produced the highest quantity of wine.
SELECT TOP 1 P.Firstname, P.Lastname, SUM(H.Quantity) AS Highest_Quantity
FROM PRODUCER P
JOIN HARVEST H
ON P.NumP = H.NumP
GROUP BY P.Firstname, P.Lastname
ORDER BY Highest_Quantity DESC;

--Calculate the average degree of wine produced.
SELECT AVG(Degree) AS AVG_Degree
FROM WINE;

--Find the oldest wine in the database.
SELECT TOP 1 NumW, Category, MIN (Year) AS Oldest_Wine FROM WINE
GROUP BY NumW, Category
ORDER BY Oldest_Wine ASC;

--Retrieve a list of producers along with the total quantity of wine they have produced.
SELECT P.Firstname, P.Lastname, SUM(H.Quantity) AS Total_Wine_Quantity
FROM PRODUCER P
JOIN HARVEST H
ON P.NumP = H.NumP
GROUP BY P.Firstname, P.Lastname
ORDER BY Total_Wine_Quantity ASC;

--Retrieve a list of wines along with their producer details.
SELECT W.NumW, Category, P.Firstname, P.Lastname, Region, Year
FROM WINE W
JOIN HARVEST H
ON W.NumW = H.NumW
JOIN PRODUCER P
ON H.NumP = P.NumP
ORDER BY NumW;