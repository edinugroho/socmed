class HashtagPost
    attr_accessor :post_id, :hashtag_id

    def valid?
        return false if @post_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end