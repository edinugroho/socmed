require_relative '../../app/models/comment_hashtag.rb'

describe CommentHashtag do
    describe '#validate' do
        before do
            @comment_hashtag = CommentHashtag.new
        end

        context 'when invalid' do
            it 'respond false' do
                response = @comment_hashtag.valid?
                expect(false).to eq(response)
            end

            it 'respond false if comment_id nil' do
                @comment_hashtag.hashtag_id = 1
                response = @comment_hashtag.valid?
                expect(false).to eq(response)
            end
        end
    end
end