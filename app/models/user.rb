require_relative '../../app/db/db_connector.rb'

class User
    attr_accessor :id, :username, :email

    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into users (username,email) values ('#{@username}','#{@email}')")
        true
    end

    def valid?
        return false if @username.nil?
        return false if @email.nil?
        true
    end
end