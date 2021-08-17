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

            it 'respond false if hashtag_id nil' do
                @comment_hashtag.comment_id = 1
                response = @comment_hashtag.valid?
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respind true' do
                @comment_hashtag.comment_id = 1
                @comment_hashtag.hashtag_id = 1
                response = @comment_hashtag.valid?
                expect(true).to eq(response)
            end
        end
    end

    describe '#insert' do
        context 'when invalid' do
            it 'respond false' do
                comment_hashtag = CommentHashtag.new
                response = comment_hashtag.save 
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond true' do
                comment_hashtag = CommentHashtag.new
                comment_hashtag.comment_id = 1
                comment_hashtag.hashtag_id = 1

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into comment_hashtags (comment_id,hashtag_id) values ('#{comment_hashtag.comment_id}','#{comment_hashtag.hashtag_id}')")
                response = comment_hashtag.save

                expect(response).to eq(true)
            end
        end
    end

    describe '#find' do
        context 'when invalid' do
            it 'respond nil' do
                comment_hashtag = CommentHashtag.new
                comment_hashtag.id = 1

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from comment_hashtags where id = '#{comment_hashtag.id}'").and_return(nil)
                response = comment_hashtag.find(comment_hashtag.id)

                expect(response).to eq(nil)
            end
        end

        context 'when valid' do
            it 'respond self object' do
                comment_hashtag = CommentHashtag.new
                comment_hashtag.id = 1
                comment_hashtag.comment_id = 1
                comment_hashtag.hashtag_id = 1

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from comment_hashtags where id = '#{comment_hashtag.id}'").and_return(comment_hashtag)
                response = comment_hashtag.find(comment_hashtag.id)
                
                expect(response).to eq(comment_hashtag)
            end
        end
    end
end