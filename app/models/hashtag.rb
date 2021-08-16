class Hashtag
    attr_accessor :id, :name
    def valid?
        return false if @name.nil?
        return false if @name[0] != '#'
        return false if @name =~ /\A\s*\Z/
        true
    end
end