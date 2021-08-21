require_relative '../db/db_connector.rb'

class Comment
    attr_accessor :user_id, :post_id, :body, :attachment

    def save
        client = create_db_client
        client.query("insert into comments (user_id, post_id, body) values (#{@user_id}, #{@post_id}, '#{@body}')")
        true
    end
end