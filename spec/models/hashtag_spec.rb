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

    describe '#insert' do
        context 'when invalid' do
            it 'respond false' do
                hashtag = Hashtag.new
                response = hashtag.save
                expect(response).to eq(false)
            end
        end

        context 'when valid' do
            it 'respond true' do
                hashtag = Hashtag.new
                hashtag.name = '#hashtag'

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into hashtags (name) values ('#{hashtag.name}')").and_return(true)
                response = hashtag.save

                expect(response).to eq(true)
            end
        end
    end

    describe '#find' do
        context 'when invalid' do
            it 'respond nil' do
                hashtag = Hashtag.new
                hashtag.id = 1
            
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from hashtags where id = '#{hashtag.id}'").and_return(nil)
                response = hashtag.find(hashtag.id)

                expect(response).to eq(nil)
            end
        end
    end
end