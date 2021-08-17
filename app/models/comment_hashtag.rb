class CommentHashtag
    attr_accessor :id, :comment_id, :hashtag_id

    def save
        return false unless valid?
    end

    def valid?
        return false if @comment_id.nil?
        return false if @hashtag_id.nil?
        true
    end
end