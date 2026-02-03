use world;
select * from city;
select * from country;
select * from countrylanguage;

Question 1 : Count how many cities are there in each country?

SELECT CountryCode, COUNT(*) AS Number_of_Cities
FROM city
GROUP BY CountryCode;

Question 2 : Display all continents having more than 30 countries.

SELECT Continent
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

Question 3 : List regions whose total population exceeds 200 million.

select Region ,sum(Population)  from country
Group by Region
having sum(Population) >200000000;

Question 4 : Find the top 5 continents by average GNP per country.

select Continent,AVG(GNP) from country
group by Continent 
order by Continent desc
limit 5;

Question 5 : Find the total number of official languages spoken in each continent.

select Continent,count(Language) from countrylanguage ,Country
where  Code = CountryCode 
AND IsOfficial ='T'
group by Continent ;

Question 6 : Find the maximum and minimum GNP for each continent.

select Continent , MAX(GNP),MIN(GNP) from Country
Group by Continent;

Question 7 : Find the country with the highest average city population.

select c.Name, Avg(ci.Population) AS Avg_Population
from  Country c
JOIN City ci ON ci.CountryCode = c.Code
group by c.Name
order by Avg_Population desc
limit 1;

Question 8 : List continents where the average city population is greater than 200,000.

select Continent,Avg(ci.Population) AS Avg_population
from country c join city ci on ci.CountryCode =c.code
group by Continent 
having Avg_Population >200000;

Question 9 : Find the total population and average life expectancy for each continent, ordered by average life
expectancy descending.

select  Continent, sum(Population) AS Total_Population , Avg(LifeExpectancy) AS Average_life_expectancy
from Country 
group by Continent
ORDER BY  Average_life_expectancy DESC;

Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
the total population is over 200 million.

select  Continent, sum(Population) AS Total_Population , AVG(LifeExpectancy) AS life_expectancy
from Country 
group by Continent
having Total_Population >2000000
ORDER BY Life_expectancy DESC
limit 3;



