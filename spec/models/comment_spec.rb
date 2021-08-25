require_relative '../../app/models/comment.rb'

describe Comment do
    describe '#save' do
        context 'when valid' do
            it 'respond true if not contain attachment' do
                comment = Comment.new
                comment.user_id = 1
                comment.post_id = 1
                comment.body = "This is comment"

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into comments (user_id, post_id, body) values (#{comment.user_id}, #{comment.post_id}, '#{comment.body}')").and_return(true)
                response = comment.save

                expect(response).to eq(true)
            end
        end
    end
end