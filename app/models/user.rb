require_relative '../../app/db/db_connector.rb'

class User
    attr_accessor :id, :username, :email, :bio

    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into users (username,email,bio) values ('#{@username}','#{@email}','#{@bio}')")
        true
    end

    def all
        client = create_db_client
        query_results = client.query("select * from users")
        users = Array.new
        query_results.each do |data|
            users.push(data)
        end
        users
    end

    def find(id)
        client = create_db_client
        query_results = client.query("select * from users where id = '#{id}'")
        if query_results == nil
            nil
        else
            query_results.each
        end
    end

    def update(id, user)
        client = create_db_client
        query_results = client.query("update users set `username`= '#{user.username}', `email` = '#{user.email}', `bio` = '#{user.bio}' where id = '#{id}'")
        true
    end

    def destroy(id)
        client = create_db_client
        query_results = client.query("delete from users where id = '#{id}'")
        true
    end

    def valid?
        return false if @username.nil?
        return false if @email.nil?
        return false if @bio.nil?
        true
    end
end