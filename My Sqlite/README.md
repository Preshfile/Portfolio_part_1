<h1>Welcome to My Sqlite</h1>

<h2>Task</h2>
<p>Create a command-line interface (CLI) program that uses a custom implementation of SQLite called "MySqlite." The program should be able to perform basic CRUD (Create, Read, Update, Delete) operations on CSV files, similar to how SQLite performs CRUD operations on SQL databases.</p>

<h2>Solution Description</h2>
<p>The folowing steps were taken to solve the problem:</p>

<p>Created a class called MySqliteRequest that behaves like a request on a real SQLite database. We implemented various methods like from, select, where, join, order, insert, values, update, set, delete, and run to build and execute the request.</p>

<p>Created a CLI program using readline and ruby called my_sqlite_cli.rb, which accepts user input and use the MySqliteRequest class to execute the requested operation on a CSV file.</p>

<h2>Installation</h2>
<p>To install the app, follow the steps below:</p>
<ul>
<li>Clone the repository from Github</li>
<li>Install the required gems by running bundle install</li>
</ul>

<h2>Usage</h2>
<p>To use the program, navigate to the directory where the my_sqlite_cli.rb file is located and run the command ruby my_sqlite_cli.rb.</p> 

<p>The program accepts requests with the following format:</p>

<p>SELECT|INSERT|UPDATE|DELETE FROM WHERE (max 1 condition) JOIN ON (max 1 condition)</p>

<p>You can also save and load databases from a file.</p>

<h2>The Core Team</h2>
<p>Authored by <strong>Precious Oranye</strong></p>
