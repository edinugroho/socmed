class Hashtag
    attr_accessor :id, :name
    def valid?
        return false if @name.nil?
        return false if @name[0] != '#'
        true
    end
end