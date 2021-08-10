require 'mysql2'

def create_db_client
    client = Mysql2::Client.new(
        :host => ENV['DB_HOST'],
        :port => ENV['DB_PORT'],
        :username => ENV['DB_USERNAME'],
        :password => ENV['DB_PASSWORD'],
        :database => ENV['DB_DATABASE']
    )
    client
end