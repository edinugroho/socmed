require_relative '../../app/controllers/comment_controller.rb'
require 'tempfile'

describe CommentController do
    describe '#store' do
        context 'when valid' do
            it 'respond true if no contains hashtag' do
                comment_controller = CommentController.new
                comment = {
                    "post_id" => 1,
                    "user_id" => 1,
                    "body" => 'Lorem ipsum',
                    'attachment' => {
                        'filename' => 'filename.jpg',
                        'tempfile' => Tempfile.new
                    }
                }
                response = comment_controller.store(comment)

                expect(response).to eq(true.to_json)
            end
            
            it 'respond true if contain hashtag' do
                comment_controller = CommentController.new
                comment = {
                    "post_id" => 1,
                    "user_id" => 1,
                    "body" => 'Lorem ipsum #comment',
                    'attachment' => {
                        'filename' => 'filename.jpg',
                        'tempfile' => Tempfile.new
                    }
                }
                response = comment_controller.store(comment)

                expect(response).to eq(true.to_json)
            end
        end
    end
end