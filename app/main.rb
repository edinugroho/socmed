require 'sinatra'
require_relative '../app/controllers/user_controller.rb'

get '/' do
    'Welcome'
end

get '/user' do
    user_controller = UserController.new
    user_controller.index
end

post '/user' do
    user_controller = UserController.new
    params = JSON.parse(request.body.read)
    user_controller.store(params) 
end