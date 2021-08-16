require_relative '../../app/models/hashtag_post.rb'

describe HashtagPost do
    describe '#validate' do
        before do
            @hashtag_post = HashtagPost.new
        end

        context 'when invalid' do
            it 'respond false' do
                response = @hashtag_post.valid?
                expect(false).to eq(response)
            end
            
            it 'respond false if post_id nil' do
                @hashtag_post.hashtag_id = 1
                response = @hashtag_post.valid?
                expect(false).to eq(response)
            end
            
            it 'respond false if hashtag_id nil' do
                @hashtag_post.post_id = 1
                response = @hashtag_post.valid?
                expect(false).to eq(response)
            end
        end
        
        context 'when valid' do
            it 'respind true' do
                @hashtag_post.post_id = 1
                @hashtag_post.hashtag_id = 1
                response = @hashtag_post.valid?
                expect(true).to eq(response)
            end
        end
    end

    describe '#insert' do
        context 'when invalid' do
            it 'respond false' do
                hashtag_post = HashtagPost.new
                response = hashtag_post.save 
                expect(false).to eq(response)
            end
        end
    end
end