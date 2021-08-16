require_relative '../db/db_connector.rb'

class HashtagPost
    attr_accessor :post_id, :hashtag_id

    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into hashtag_posts (post_id,hashtag_id) values ('#{@post_id}','#{@hashtag_id}')")
        true
    end

    def valid?
        return false if @post_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end