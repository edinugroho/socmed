require_relative '../../app/db/db_connector.rb'

class Post
    attr_accessor :id, :user_id, :body, :attachment
    
    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into posts (user_id,body,attachment) values ('#{@user_id}','#{@body}','#{@attachment}')")
        true
    end

    def valid?
        return false if @body.nil?
        return false if @body.length > 1000
        true
    end
end