require_relative '../../app/controllers/post_controller.rb'

describe PostController do
    describe '#store' do
        context 'when valid' do
            it 'respond true if no contains hashtag' do
                post_controller = PostController.new
                post = {
                    :user_id => 1,
                    :body => 'Lorem ipsum'
                }
                response = post_controller.store(post.to_json)

                expect(response).to eq(true.to_json)
            end
        end
    end
end