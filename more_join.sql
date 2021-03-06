-- More JOIN operations
--List the films where the yr is 1962 [Show id, title] 
--Give year of 'Citizen Kane'. 
--List all of the Star Trek movies, include the id, title and yr 
--(all of these movies include the words Star Trek in the title). Order results by year. 
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;
--What id does the actor 'Glenn Close' have? 
SELECT id
FROM actor
WHERE name LIKE 'Glenn Close';
--What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title LIKE 'Casablanca';
--Obtain the cast list for 'Casablanca'. 
SELECT name FROM casting JOIN actor
          ON casting.actorid=actor.id
  WHERE movieid=11768;
--Obtain the cast list for the film 'Alien' 
SELECT name FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
  WHERE movie.title = 'Alien';
--List the films in which 'Harrison Ford' has appeared 
SELECT title FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
  WHERE actor.name='Harrison Ford';
--List the films where 'Harrison Ford' has appeared - but not in the starring role. 
--[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
SELECT title FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
  WHERE actor.name='Harrison Ford' and casting.ord > 1;
--List the films together with the leading star for all 1962 films. 
SELECT title, actor.name FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
  WHERE movie.yr = '1962' and casting.ord = 1;
--Which were the busiest years for 'Rock Hudson', show the year and the number of movies 
--he made each year for any year in which he made more than 2 movies. 
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
ORDER BY COUNT(title) DESC;
--List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
SELECT title, name
FROM movie JOIN casting ON (movieid=movie.id AND ord=1)
           JOIN actor ON (actorid=actor.id)
WHERE movieid IN (
SELECT movieid FROM casting
WHERE actorid IN (179)
);
--Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 

SELECT name
FROM movie JOIN casting ON (movieid=movie.id AND ord=1)
           JOIN actor ON (actorid=actor.id)
GROUP BY name
HAVING COUNT(name) >= 15
ORDER BY name;
--List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
SELECT title, COUNT(actorid)
FROM movie JOIN casting ON (movieid=movie.id)
WHERE yr='1978'
GROUP BY title
HAVING COUNT(actorid) > 1
ORDER BY COUNT(actorid) DESC, title;

--List all the people who have worked with 'Art Garfunkel'. 
SELECT actor.name 
FROM movie JOIN casting ON (movieid=movie.id)
           JOIN actor on (actorid=actor.id)
WHERE movieid IN (
 SELECT movieid FROM casting
 WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Art Garfunkel')
) AND actor.name != 'Art Garfunkel';