class Post
    attr_accessor :id, :user_id, :body, :attachment

    def valid?
        return false if @body.nil?
        return false if @body.length > 1000
        true
    end
end