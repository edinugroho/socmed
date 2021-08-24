require 'json'
require_relative '../models/comment.rb'

class CommentController 
    def store(params)
        comment = Comment.new
        comment.post_id = params['post_id']
        comment.user_id = params['user_id']
        comment.body = params['body']
        filename = params['attachment']['filename']
        file = params['attachment']['tempfile']
        File.open("app/media/#{filename}", 'wb') do |f|
            f.write(file.read)
        end
        comment.attachment = "app/media/#{filename}"
        comment.save.to_json
    end 
end