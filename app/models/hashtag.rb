require_relative '../../app/db/db_connector.rb'

class Hashtag
    attr_accessor :id, :name
    
    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into hashtag (name) values ('#{@name}')")
        true
    end

    def valid?
        return false if @name.nil? 
        !!@name.match(/(\#[a-zA-Z0-9]+\b)/)
    end
end