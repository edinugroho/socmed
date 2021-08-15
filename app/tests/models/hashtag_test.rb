require_relative '../../models/hashtag.rb'

describe 'Hashtag' do
    describe '#validate' do
        before do
            @hashtag = Hashtag.new
        end

        context 'when invalid' do
            it 'respond false' do
                response = @hashtag.valid?
                expect(false).to eq(response)
            end
        end
    end
end