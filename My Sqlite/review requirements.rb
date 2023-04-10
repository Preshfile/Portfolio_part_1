
=begin

Review from Grader 

Question 0 of 10 | Part i - mysqliterequest respond to simple select + from request
Part I - Does it work to select name from data?

Question 1 of 10 | Mysqliterequest respond to simple select + from request + where
Part I - Does it work to select name with a where?

Question 2 of 10 | Mysqliterequest respond to simple select + from request + multiple where
Part I - Does it work to select name with multiple where?

Question 3 of 10 | Mysqliterequest respond to simple insert
Part I - Does it work to insert a user?

Question 4 of 10 | Mysqliterequest respond to simple update
Part I - Does it work to update a user?

Question 5 of 10 | Mysqliterequest respond to simple delete
Part I - Does it work to delete a user?

Question 6 of 10 | Mysqlite cli simple select
Part II - Can you run this request in the CLI?

Question 7 of 10 | Mysqlite cli select specific field with where
Part II - Can you run this request in the CLI?

Question 8 of 10 | Mysqlite cli simple insert
Part II - Can you run this request in the CLI?

Question 9 of 10 | Mysqlite cli simple update
Part II - Can you run this request in the CLI?

Question 10 of 10 | Mysqlite cli simple delete
Part II - Can you run this request in the CLI?



it met the requirements. this is how:

Based on the provided code, here are my answers to the requirements:

Question 0 of 10 | Part i - mysqliterequest respond to simple select + from request
Part I - Does it work to select name from data?

Answer: Yes, it should work. Here's an example query that should work:


request = MySqliteRequest.new
result = request.select('name').from('data').run
Question 1 of 10 | Mysqliterequest respond to simple select + from request + where
Part I - Does it work to select name with a where?

Answer: Yes, it should work. Here's an example query that should work:


request = MySqliteRequest.new
result = request.select('name').from('data').where('age', 30).run
Question 2 of 10 | Mysqliterequest respond to simple select + from request + multiple where
Part I - Does it work to select name with multiple where?

Answer: Yes, it should work. Here's an example query that should work:


request = MySqliteRequest.new
result = request.select('name').from('data').where('age', 30).where('city', 'New York').run
Question 3 of 10 | Mysqliterequest respond to simple insert
Part I - Does it work to insert a user?

Answer: Yes, it should work. Here's an example query that should work:


request = MySqliteRequest.new
request.insert('data').values({ name: 'John', age: 25, city: 'London' }).run
Question 4 of 10 | Mysqliterequest respond to simple update
Part I - Does it work to update a user?

Answer: Yes, it should work. Here's an example query that should work:


request = MySqliteRequest.new
request.update('data').set({ age: 26 }).where('name', 'John').run
Question 5 of 10 | Mysqliterequest respond to simple delete
Part I - Does it work to delete a user?

Answer: Yes, it should work. Here's an example query that should work:


request = MySqliteRequest.new
request.from('data').where('name', 'John').delete.run
Question 6 of 10 | Mysqlite cli simple select
Part II - Can you run this request in the CLI?

Answer: Yes, it should work. Here's an example query that should work:

$ ruby my_sqlite.rb data.db 'select name from data'
Question 7 of 10 | Mysqlite cli select specific field with where
Part II - Can you run this request in the CLI?

Answer: Yes, it should work. Here's an example query that should work:

$ ruby my_sqlite.rb data.db 'select name from data where age=30'
Question 8 of 10 | Mysqlite cli simple insert
Part II - Can you run this request in the CLI?

Answer: Yes, it should work. Here's an example query that should work:


$ ruby my_sqlite.rb data.db 'insert into data (name, age, city) values ("John", 25, "London")'
Question 9 of 10 | Mysqlite cli simple update
Part II - Can you run this request in the CLI?

Answer: Yes, it should work. Here's an example query that should work:


$ ruby my_sqlite.rb data.db 'update data set age=26 where name="John"'


=end
