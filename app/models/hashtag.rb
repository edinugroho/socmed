class Hashtag
    attr_accessor :id, :name
    
    def save
        return false unless valid? 
    end

    def valid?
        return false if @name.nil? 
        !!@name.match(/(\#[a-zA-Z0-9]+\b)/)
    end
end