require_relative '../../app/db/db_connector.rb'
require_relative '../../app/models/hashtag.rb'
require_relative '../../app/models/hashtag_post.rb'

class Post
    attr_accessor :id, :user_id, :body, :attachment
    
    def save
        return false unless valid?
        client = create_db_client
        if @attachment.nil? 
            client.query("insert into posts (user_id,body) values (#{@user_id},'#{@body}')")
        else
            client.query("insert into posts (user_id,body,attachment) values (#{@user_id},'#{@body}','#{@attachment}')")
        end
        words = @body.split(' ')
        words.each do |word|
            hashtag = Hashtag.new
            hashtag_post = HashtagPost.new
            hashtag.name = word
            if hashtag.valid?
                hashtag_post.post_id = client.last_id
                hashtag_post.hashtag_id = hashtag.save
                hashtag_post.save
            end
        end
        true
    end

    def all
        client = create_db_client
        query_results = client.query("select * from posts")
        posts = Array.new
        query_results.each do |data|
            posts.push(data)
        end
        posts
    end

    def find(id)
        client = create_db_client
        query_results = client.query("select * from posts where id = '#{id}'")
        if query_results == nil
            nil
        else
            @id = query_results.id
            @user_id = query_results.user_id
            @body = query_results.body
            @attachment = query_results.attachment
            self
        end       
    end

    def update(post)
        client = create_db_client
        query_results = client.query("update posts set `body`= '#{post.body}', `attachment` = '#{post.attachment}' where id = '#{@id}'")
        true
    end

    def delete
        client = create_db_client
        query_results = client.query("delete from posts where id = '#{@id}'")
        true
    end

    def find_by_hashtag(hashtag)
        client = create_db_client
        query_results = client.query("select posts.*, hashtags.name from posts join hashtag_posts on hashtag_posts.post_id = posts.id join hashtags on hashtag_posts.hashtag_id = hashtags.id where hashtags.name = '##{hashtag}';")
        if query_results == nil
            nil
        else
            query_results.each
        end
    end

    def valid?
        return false if @user_id.to_s.empty?
        return false if @body.nil?
        return false if @body.length > 1000
        true
    end
end