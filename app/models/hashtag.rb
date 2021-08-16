require_relative '../../app/db/db_connector.rb'

class Hashtag
    attr_accessor :id, :name
    
    def save
        return false unless valid? 
        client = create_db_client
        client.query("insert into hashtags (name) values ('#{@name}')")
        true
    end

    def all
        client = create_db_client
        query_results = client.query("select * from hashtags")
        hashtags = Array.new
        query_results.each do |data|
            hashtag = Hashtag.new
            hashtag.name = data.name
            hashtags.push(hashtag)
        end
        hashtags
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

    def update(hashtag)
        client = create_db_client
        query_results = client.query("update hashtags set `name`= '#{hashtag.name}' where id = '#{@id}'")
        true
    end

    def delete
        client = create_db_client
        query_results = client.query("delete from hashtags where id = '#{@id}'")
        true
    end

    def valid?
        return false if @name.nil? 
        !!@name.match(/(\#[a-zA-Z0-9]+\b)/)
    end
end