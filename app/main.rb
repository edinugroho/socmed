require 'sinatra'
require_relative '../app/controllers/user_controller.rb'
require_relative '../app/controllers/post_controller.rb'

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

get '/user/:id' do
    user_controller = UserController.new
    user_controller.show(params['id'])
end

put '/user/:id' do
    user_controller = UserController.new
    body = JSON.parse(request.body.read)
    user_controller.update(params['id'], body)
end

delete '/user/:id' do
    user_controller = UserController.new
    user_controller.destroy(params['id'])
end

post '/post' do
    post_controller = PostController.new
    params = JSON.parse(request.body.read) 
    post_controller.store(params) 
end