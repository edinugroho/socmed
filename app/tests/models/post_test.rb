require_relative '../../models/post.rb'

describe 'Post' do
    describe '#validate' do
        before do
            @post = Post.new
        end

        context 'when invalid' do
            it 'respond false' do
                response = @post.valid?
                expect(false).to eq(response)
            end

            it 'respond false if text too long' do
                @post.body = 'body'*1000
                response = @post.valid?
                expect(false).to eq(response)
            end
            
            it 'respond false if body nil' do
                response = @post.valid?
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond true' do
                @post.body = "post body"
                response = @post.valid?
                expect(true).to eq(response)
            end
        end
    end

    describe '#insert' do
        context 'when invalid' do
            it 'respond false' do
                post = Post.new
                response = post.save
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond true' do
                post = Post.new
                post.user_id = 1
                post.body = "post body"
                post.attachment = "attachment.jpg"
                
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into posts (user_id,body,attachment) values ('#{post.user_id}','#{post.body}','#{post.attachment}')")
                post.save
            end
        end
    end
end