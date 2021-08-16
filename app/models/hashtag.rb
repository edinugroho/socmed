require_relative '../../app/db/db_connector.rb'

class Hashtag
    attr_accessor :id, :name
    
    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into hashtag (name) values ('#{@name}')")
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
        return false if @name.nil? 
        !!@name.match(/(\#[a-zA-Z0-9]+\b)/)
    end
end