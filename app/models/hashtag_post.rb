require_relative '../db/db_connector.rb'

class HashtagPost
    attr_accessor :id, :post_id, :hashtag_id

    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into hashtag_posts (post_id,hashtag_id) values ('#{@post_id}','#{@hashtag_id}')")
        true
    end

    def find(id)
        client = create_db_client
        query_results = client.query("select * from hashtags where id = '#{id}'")
        if query_results == nil
            nil
        else
            @id = query_results.id
            @name = query_results.name
            self
        end 
    end

    def valid?
        return false if @post_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end