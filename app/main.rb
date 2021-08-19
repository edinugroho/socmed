require 'sinatra'
require_relative '../app/controllers/user_controller.rb'

get '/' do
    'Welcome'
end

get '/user' do
    user_controller = UserController.new
    user_controller.index
end