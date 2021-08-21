require_relative '../../app/models/post.rb'

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
                expect(mock_client).to receive(:query).with("insert into posts (user_id,body,attachment) values (#{post.user_id},'#{post.body}','#{post.attachment}')")
                post.save
            end
        end
    end

    describe '#find' do
        context 'when invalid' do
            it 'respond false' do
                post = Post.new
                post.id = 1

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from posts where id = '#{post.id}'").and_return(nil)
                response = post.find(post.id)

                expect(nil).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond self object' do
                post = Post.new
                post.id = 1
                post.user_id = 1
                post.body = "post body"
                post.attachment = "attachment.jpg"

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from posts where id = '#{post.id}'").and_return(post)
                response = post.find(post.id)

                expect(post).to eq(response)
            end
        end
    end

    describe '#update' do
        context 'when valid' do
            it 'respond true' do
                change_post = Post.new
                change_post.body = 'post body'
                change_post.attachment = "attachment.jpg"

                post = Post.new
                post.id = 1

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from posts where id = '#{post.id}'").and_return(post)
                expect(mock_client).to receive(:query).with("update posts set `body`= '#{change_post.body}', `attachment` = '#{change_post.attachment}' where id = '#{post.id}'").and_return(true)
                response = post.find(1).update(change_post)
                
                expect(true).to eq(response)
            end
        end
    end

    describe '#delete' do
        context 'when valid' do
            it 'respond true' do
                post = Post.new
                post.id = 1
                
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from posts where id = '#{post.id}'").and_return(post)
                expect(mock_client).to receive(:query).with("delete from posts where id = '#{post.id}'").and_return(true)
                response = post.find(1).delete

                expect(true).to eq(response)
            end
        end
    end

    describe '#all' do
        context 'when valid' do
            it 'respond all object post from databases' do
                post = Post.new

                post_1 = Post.new
                post_1.user_id = 1
                post_1.body = "post body 1"
                post_1.attachment = "attachment1.jpg"
                
                post_2 = Post.new
                post_2.user_id = 1
                post_2.body = "post body 2"
                post_2.attachment = "attachment2.jpg"
                
                post_3 = Post.new
                post_3.user_id = 1
                post_3.body = "post body 3"
                post_3.attachment = "attachment3.jpg"

                posts = [post_1, post_2, post_3]

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from posts").and_return(posts)
                post.all
                
                posts.each_with_index do |post, index|
                    expect(post.user_id).to eq(posts[index].user_id)
                    expect(post.body).to eq(posts[index].body)
                    expect(post.attachment).to eq(posts[index].attachment)
                end
            end
        end
    end
end