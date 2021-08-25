require_relative '../db/db_connector.rb'
require_relative '../../app/models/hashtag.rb'
require_relative '../../app/models/comment_hashtag.rb'

class Comment
    attr_accessor :user_id, :post_id, :body, :attachment

    def save
        client = create_db_client
        if @attachment.nil? 
            client.query("insert into comments (user_id, post_id, body) values (#{@user_id}, #{@post_id}, '#{@body}')")
        else
            client.query("insert into comments (user_id, post_id, body, attachment) values (#{@user_id}, #{@post_id}, '#{@body}', '#{@attachment}')")
        end
        words = @body.split(' ')
        words.each do |word|
            hashtag = Hashtag.new
            comment_hashtag = CommentHashtag.new
            hashtag.name = word
            if hashtag.valid?
                comment_hashtag.comment_id = client.last_id
                comment_hashtag.hashtag_id = hashtag.save
                comment_hashtag.save
            end
        end
        true
    end

    def valid?
        return false if @user_id.to_s.empty?
    end
end