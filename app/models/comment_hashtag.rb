class CommentHashtag
    attr_accessor :id, :comment_id, :hashtag_id

    def valid?
        return false if @comment_id.nil?
        true
    end
end