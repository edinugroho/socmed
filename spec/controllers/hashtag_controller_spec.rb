require_relative '../../app/controllers/hashtag_controller.rb'

describe HashtagController do
    describe '#trending' do
        context 'when valid' do
            it 'respond trending hashtag within 24 hours' do
                hashtag_controller = HashtagController.new
                response = hashtag_controller.trending

                expect(response).to eq(hashtag_controller.trending)
            end
        end
    end
end