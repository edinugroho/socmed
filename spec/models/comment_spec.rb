require_relative '../../app/models/comment.rb'

describe Comment do
    describe '#validate' do
        context 'when invalid' do
            it 'respond false if user_id nil' do
                comment = Comment.new
                comment.post_id = 1
                comment.body = "This is comment"
                comment.attachment = "attachment.jpg"
                response = comment.valid?

                expect(response).to eq(false)
            end 
            
            it 'respond false if post_id nil' do
                comment = Comment.new
                comment.user_id = 1
                comment.body = "This is comment"
                comment.attachment = "attachment.jpg"
                response = comment.valid?

                expect(response).to eq(false)
            end 

            it 'respond false if body nil' do
                comment = Comment.new
                comment.user_id = 1
                comment.post_id = 1
                comment.attachment = "attachment.jpg"
                response = comment.valid?

                expect(response).to eq(false)
            end 
        end
        
        context 'when valid' do
            it 'respond true' do
                comment = Comment.new
                comment.user_id = 1
                comment.post_id = 1
                comment.body = "This is comment"
                comment.attachment = "attachment.jpg"
                response = comment.valid?

                expect(response).to eq(true)
            end
        end
    end
    describe '#save' do
        context 'when valid' do
            it 'respond true if contain attachment' do
                comment = Comment.new
                comment.user_id = 1
                comment.post_id = 1
                comment.body = "This is comment"
                comment.attachment = "attachment.jpg"

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into comments (user_id, post_id, body, attachment) values (#{comment.user_id}, #{comment.post_id}, '#{comment.body}', '#{comment.attachment}')").and_return(true)
                response = comment.save

                expect(response).to eq(true)
            end
            
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