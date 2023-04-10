
require 'sqlite3'

class User
  attr_accessor :id, :firstname, :lastname, :age, :password, :email
  
  def initialize(id = 0, firstname, lastname, age, password, email)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @age = age
    @password = password
    @email = email
  end
  
  def self.db_connection
    begin
      db = SQLite3::Database.open('db.sql')
      db.execute("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, firstname STRING, lastname STRING, age INTEGER, email STRING, password STRING)")
      db.results_as_hash = true
      db
    rescue SQLite3::Exception => e
      puts "Error occurred: "
      puts e
    end
  end
  
  def self.create(user_info)
    db = db_connection
    db.execute("INSERT INTO users(firstname, lastname, age, email, password) VALUES(?,?,?,?,?)", user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:email], user_info[:password])
    user = User.new(db.last_insert_row_id, user_info[:firstname], user_info[:lastname], user_info[:age], '', user_info[:email])
    db.close
    user
  end
  
  def self.all
    db = db_connection
    users = db.execute("SELECT * FROM users")
    db.close
    users
  end
  
  def self.find(user_id)
    db = db_connection
    user = db.execute("SELECT * FROM users WHERE id = ?", user_id)
    user_info = User.new(user[0]["id"], user[0]["firstname"], user[0]["lastname"], user[0]["age"], user[0]["password"], user[0]["email"])
    db.close
    user_info
  end
  
  def self.update(user_id, attribute, value)
    db = db_connection
    db.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", value, user_id)
    user = db.execute("SELECT * FROM users where id = ?", user_id)
    db.close
    user
  end
  
  def self.authenticate(password, email)
    db = db_connection
    user = db.execute("SELECT * FROM users WHERE email = ? AND password = ?", email, password)
    db.close
    user
  end
  
  def self.destroy(user_id)
    db = db_connection
    db.execute("DELETE FROM users WHERE id = #{user_id}")
    db.close
  end
end