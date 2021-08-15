require_relative '../../app/db/db_connector.rb'

class Post
    attr_accessor :id, :user_id, :body, :attachment
    
    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into posts (user_id,body,attachment) values ('#{@user_id}','#{@body}','#{@attachment}')")
        true
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

    def valid?
        return false if @body.nil?
        return false if @body.length > 1000
        true
    end
end