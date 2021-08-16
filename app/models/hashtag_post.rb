class HashtagPost
    attr_accessor :post_id, :hashtag_id

    def save
        return false unless valid? 
    end

    def valid?
        return false if @post_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end