require_relative '../db/db_connector.rb'

class CommentHashtag
    attr_accessor :id, :comment_id, :hashtag_id

    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into comment_hashtags (comment_id,hashtag_id) values ('#{@comment_id}','#{@hashtag_id}')")
        true
    end

    def all
        client = create_db_client
        query_results = client.query("select * from comment_hashtags")
        comment_hashtags = Array.new
        query_results.each do |data|
            comment_hashtag = CommentHashtag.new
            comment_hashtag.comment_id = data.comment_id
            comment_hashtag.hashtag_id = data.hashtag_id
            comment_hashtags.push(comment_hashtag)
        end
        comment_hashtags
    end

    def find(id)
        client = create_db_client
        query_results = client.query("select * from comment_hashtags where id = '#{id}'")
        if query_results == nil
            nil
        else
            @id = query_results.id
            @comment_id = query_results.comment_id
            @hashtag_id = query_results.hashtag_id
            self
        end 
    end
    
    def delete
        client = create_db_client
        query_results = client.query("delete from comment_hashtags where id = '#{@id}'")
        true
    end

    def update(comment_hashtag)
        client = create_db_client
        query_results = client.query("update comment_hashtags set `comment_id`= '#{comment_hashtag.comment_id}', `hashtag_id` = '#{comment_hashtag.hashtag_id}' where id = '#{@id}'")
        true
    end

    def valid?
        return false if @comment_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end