
requests['Display all actors'] = "SELECT * FROM actors;"
requests['Display all genres'] = "SELECT * FROM genres;"
requests['Display the name and year of the movies'] = "SELECT mov_title, mov_year FROM movies;"
requests['Display reviewer name from the reviews table'] = "SELECT rev_name FROM reviews;"

requests["Find the year when the movie American Beauty released"] = "SELECT mov_year FROM movies WHERE mov_title = 'American Beauty';"
requests["Find the movie which was released in the year 1999"] = "SELECT mov_title FROM movies WHERE mov_year = 1999;"
requests["Find the movie which was released before 1998"] = "SELECT mov_title FROM movies WHERE mov_year < 1998;"
requests["Find the name of all reviewers who have rated 7 or more stars to their rating order by reviews rev_name (it might have duplicated names :-))"] = "SELECT rev_name FROM reviews JOIN movies_ratings_reviews ON reviews.id = movies_ratings_reviews.rev_id WHERE rev_stars >= 7 ORDER BY rev_name;"
requests["Find the titles of the movies with ID 905, 907, 917"] = "SELECT mov_title FROM movies WHERE id IN (905, 907, 917);"
requests["Find the list of those movies with year and ID which include the words Boogie Nights"] = "SELECT id, mov_title, mov_year FROM movies WHERE mov_title LIKE '%Boogie%Nights%';"
requests["Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'"] = "SELECT id FROM actors WHERE act_fname = 'Woody' AND act_lname = 'Allen';"

requests["Find the actors with all information who played a role in the movies 'Annie Hall'"] = "SELECT actors.* FROM actors JOIN movies_actors ON actors.id = movies_actors.act_id JOIN movies ON movies.id = movies_actors.mov_id WHERE movies.mov_title = 'Annie Hall';"
requests["Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production"] = "SELECT act_fname, act_lname, role FROM actors JOIN movies_actors ON actors.id = movies_actors.act_id JOIN movies ON movies.id = movies_actors.mov_id WHERE movies.mov_title = 'Annie Hall';"

requests["Find the name of movie and director who directed a movies that casted a role as Sean Maguire"] = "SELECT b.dir_fname, b.dir_lname, a.mov_title FROM movies a, directors b, movies_actors c, directors_movies d WHERE c.role = 'Sean Maguire' AND a.id = d.mov_id AND c.mov_id = a.id AND d.dir_id = b.id"

requests["Find all the actors who have not acted in any movie between 1990 and 2000 (select only actor first name, last name, movie title and release year)"] = "SELECT a.act_fname, a.act_lname, b.mov_title, 
b.mov_year FROM actors a, movies b, movies_actors c
WHERE b.mov_year NOT BETWEEN 1990 AND 2000 AND  a.id = c.act_id AND b.id = c.mov_id 
AND a.id IN (SELECT a.act_id from movies_actors a, movies b WHERE b.mov_year BETWEEN 1990 AND 2000) ORDER BY b.id"


