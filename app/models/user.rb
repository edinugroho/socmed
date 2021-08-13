require_relative '../../app/db/db_connector.rb'

class User
    attr_accessor :id, :username, :email

    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into users (username,email) values ('#{@username}','#{@email}')")
        true
    end

    def find(id)
        client = create_db_client
        query_results = client.query("select * from users where id = '#{id}'")
        if query_results == nil
            nil
        else
            @id = query_results.id
            @username = query_results.username
            @email = query_results.email
            self
        end
    end

    def update(user)
        client = create_db_client
        query_results = client.query("update user set `username`= '#{user.username}', `email` = '#{user.email}' where id = '#{@id}'")
        true
    end

    def delete
        client = create_db_client
        query_results = client.query("")
    end

    def valid?
        return false if @username.nil?
        return false if @email.nil?
        true
    end
end