require 'json'
require_relative '../models/post.rb'

class PostController
    def index
        post = Post.new
        post = post.all
        post.to_json
    end
    
    def store(params)
        post = Post.new
        post.user_id = params['user_id']
        post.body = params['body']
        filename = params['attachment']['filename']
        file = params['attachment']['tempfile']
        File.open("app/media/#{filename}", 'wb') do |f|
            f.write(file.read)
        end
        post.attachment = "app/media/#{filename}"
        post.save.to_json
    end 
    
    def find_by_hashtag(params)
        post = Post.new
        post.find_by_hashtag(params).to_json
    end
end