<h1>Welcome to My User's App</h1>

<p>This project involves implementing a basic MVC architechture to create a Users
class with methods to create, find, get, get all users, update and destroy users
using SQLite3.</p>

<p>In Part II, a controller is created with multiple routes that interact with the User class,
and a new route is added in Part III that responds with an HTML view of all the users.</p>

<h2>Task</h2>
<h3>Part I:</h3> 
<p>Create a User class with the following methods: create, find, all, update, and destroy.</p>
<ul>
<li>Use the sqlite3 gem to create a db.sql database with a users table that includes attributes for firstname, lastname, age, password, and email.</li>
<li>Implement the create method to create a new user and return a unique ID.</li>
<li>Implement the find method to retrieve a user based on the provided user ID and return all user information.</li>
<li>Implement the all method to retrieve all users and return a hash of users.</li>
<li>Implement the update method to retrieve a user based on the provided user ID, update the specified attribute with the provided value, and return the updated user hash.</li>
<li>Implement the destroy method to retrieve a user based on the provided user ID and delete the user from the database.</li>
</ul>

<h3>Part II:</h3> 
<p>Create a controller that utilizes the User class from Part I.</p>
<strong>Implement the following routes:</strong>
<ul>
<li>GET on /users to retrieve all users (without their passwords).</li>
<li>POST on /users to create a user and store it in the database. Return the created user (without password).</li>
<li>POST on /sign_in to sign in a user by adding a session containing the user ID. </li>
<li>Return the created user (without password).</li>
<li>PUT on /users to update the current user's password. Return the updated user (without password).</li>
<li>DELETE on /sign_out to sign out the current user. Return nothing (code 204 in HTTP).</li>
<li>DELETE on /users to sign out the current user and delete the current user from the database. </li>
<li>Return nothing (code 204 in HTTP).</li>
</ul>

<h3>Part III:</h3>
<ul>
<li>Create a route for / that will return an HTML template.</li>
<li>Create a subdirectory named views and add an index.html file.</li>
<li>Implement the index.html file with a table that will display user information.</li>
</ul>

<h2>Solution Description</h2>

<p>Below is the summary of the solution</p>

<h3>Part I:</h3>
<ul>
<li>In this part, a User class was created with several methods to create, find, update, and delete users in a SQLite3 database. </li>
<li>Implemented methods that will:</li>
<ul>
 <li>Create a new user, </li>
 <li>Retrieve a user based on their ID,</li> 
 <li>Retrieve all users, </li>
 <li>Update a user's attribute, and </li>
 <li>Delete a user. </li>
</ul>
<li>Additionally, created a database table to store user information, including their first name, last name, age, email, and password.</li>
</ul>


<h3>Part II:</h3>

<p>In this part, a controller was created that uses the User class from Part I to implement several routes.</p>
<p>The routes will allow the retrieval of all users, create a new user and store it in the database, sign in a user, update the current user's password, sign out the current user, and delete the current user from the database. </p>

<p>You can also return appropriate HTTP status codes, such as 204, for successful deletion.</p>

<h3>Part III:</h3>

<p>In this part, a route was create that returns an HTML template. A subdirectory named "views" was created and an "index.html" file that displays user information in a table format was added.</p>

<h2>Installation</h2>
<p>The program requires the installation of the sqlite3 gem to interact with theSQLite3 database.</p>
<p>The project also requires a web framework such as Sinatra or Rails to create the routes.</p>

<h2>Usage</h2>
<p>The program can be used by running a local server using the command 'ruby app.rb'.
The routes can be accessed by making requests to the appropriate URL using tools
such as 'curl' or a web browser. For example, to create a new user, a POST requests
can be made to the URL 'http://localhost:8080/users' with the requires user information in the 
request body. To access the HTML view of all the users, a GET request can be made to the URL 'http://localhost:8080/'</p>

<h2>The Core Team</h2>
<p>Authored by <strong>Precious Oranye</strong></p>