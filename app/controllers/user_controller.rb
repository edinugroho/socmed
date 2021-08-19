require 'json'
require_relative '../models/user.rb'

class UserController
    def index
        user = User.new
        users = user.all
        users.to_json
    end
end