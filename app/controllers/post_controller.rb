require 'json'
require_relative '../models/post.rb'

class PostController
   def store(params)
       post = Post.new
       post.user_id = params['user_id']
       post.body = params['body']
       post.attachment = params['attachment']
       post.save.to_json
   end 
end