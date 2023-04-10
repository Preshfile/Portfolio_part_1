
require 'json'
require 'sinatra'
require_relative 'my_user_model.rb'

# Set up the server
set :bind, '0.0.0.0'
set :port, 8080
enable :sessions

# Render a list of all users
get '/' do
  @users = User.all()
  erb :html
end

# Return a JSON array of all users
get '/users' do
  status 200
  User.all.map { |user| user.slice("firstname", "lastname", "age", "email") }.to_json
end

# Sign in the user
post '/sign_in' do
  user = User.authenticate(params[:password], params[:email])
  if !user.empty?
    status 200
    session[:user_id] = user[0]["id"]
    user[0].to_json
  else
    status 401
  end
end

post '/users' do
    if params[:firstname] != nil
      params[:age] = params[:age].to_i # convert age to integer
      new_user = User.create(params)
      user = {
        :firstname => new_user.firstname,
        :lastname => new_user.lastname,
        :age => new_user.age,
        :password => new_user.password,
        :email => new_user.email
      }.to_json
      status 201
      user
    else
      existing_user = User.authenticate(params[:password], params[:email])
      if !existing_user[0].empty?
        status 200
        session[:user_id] = existing_user[0]["id"]
        existing_user[0].to_json
      else
        status 401
      end
    end
  end

# Update the user's password
put '/users' do
  User.update(session[:user_id], 'password', params[:password])
  user = User.find(session[:user_id])
  status 200
  user_info = {:firstname => user.firstname, :lastname => user.lastname, :age => user.age, :password => user.password, :email => user.email}.to_json
  user_info
end

# Sign out the user
delete '/sign_out' do
  session[:user_id] = nil unless session[:user_id].nil?
  status 204
end

# Delete the user's account
delete '/users' do
  # MyUserModel.destroy(session[:user_id]) if session[:user_id]
  session[:user_id] = nil
  status 204
end
