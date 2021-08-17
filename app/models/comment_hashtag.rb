require_relative '../db/db_connector.rb'

class CommentHashtag
    attr_accessor :id, :comment_id, :hashtag_id

    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into comment_hashtags (comment_id,hashtag_id) values ('#{@comment_id}','#{@hashtag_id}')")
        true
    end
    
    def valid?
        return false if @comment_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end