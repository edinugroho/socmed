require_relative '../../app/models/hashtag.rb'

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
            
            it 'respond false if first character not #' do
                @hashtag.name = 'hashtag'
                response = @hashtag.valid?
                expect(response).to eq(false)
            end
            
            it 'respond false if contain space' do
                @hashtag.name = 'hashtag with space'
                response = @hashtag.valid?
                expect(response).to eq(false)
            end
        end

        context 'when valid' do
            it 'respond true' do
                @hashtag.name = "#hashtag coba"
                response = @hashtag.valid?
                expect(response).to eq(true)
            end
        end
    end
end