require_relative '../../app/controllers/post_controller.rb'

describe PostController do
    
    before do
        client = create_db_client
        client.query('SET GLOBAL FOREIGN_KEY_CHECKS=0;')
    end

    describe '#all' do
        context 'when valid' do
            it 'respond json all posts' do
                post_controller = PostController.new
                response = post_controller.index
                
                expect(post_controller.index).to eq(response)
            end
        end
    end

    describe '#store' do
        context 'when valid' do
            it 'respond true if no contains hashtag' do
                post_controller = PostController.new
                post = {
                    "user_id" => 1,
                    "body" => 'Lorem ipsum'
                }
                response = post_controller.store(post)

                expect(response).to eq(true.to_json)
            end
        end
    end

    describe '#find_by_hashtag' do
        context 'when valid' do
            it 'respond post with relevant hashtag' do
                post_controller = PostController.new
                expect_post = [{
                    "id": 2,
                    "user_id": 1,
                    "body": "this is post #test",
                    "attachment": "image.jpg",
                    "created_at": "2021-08-21 21:58:35 +0700",
                    "updated_at": "2021-08-21 21:58:35 +0700",
                    "name": "#test"
                }]
                response = post_controller.find_by_hashtag('test')
                
                expect(response).to eq(expect_post.to_json)
            end
        end
    end
end