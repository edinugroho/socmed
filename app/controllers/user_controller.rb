require 'json'
require_relative '../models/user.rb'

class UserController
    def index
        user = User.new
        users = user.all
        users.to_json
    end

    def store(params)
        user = User.new
        user.username = params['username']
        user.email = params['email']
        user.bio = params['bio']
        user.save.to_json
    end
end