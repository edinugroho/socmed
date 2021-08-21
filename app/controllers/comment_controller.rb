require 'json'
require_relative '../models/comment.rb'

class CommentController 
    def store(params)
        post = Comment.new
        post.user_id = params['user_id']
        post.post_id = params['post_id']
        post.body = params['body']
        post.attachment = params['attachment']
        post.save.to_json
    end 
end