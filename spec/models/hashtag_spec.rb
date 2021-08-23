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
            it 'respond last inserted id' do
                hashtag = Hashtag.new
                hashtag.name = '#hashtag'
                last_id = 1

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into hashtags (name) values ('#{hashtag.name}')")
                expect(mock_client).to receive(:last_id).and_return(last_id)
                response = hashtag.save
                
                expect(response).to eq(last_id)
            end
        end
    end

    describe '#exist' do
        context 'when exist' do
            it 'respond id' do
                hashtag = Hashtag.new
                hashtag.id = 10
                hashtag.name = '#existHashtag'

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("SELECT id FROM hashtags WHERE name = '#{hashtag.name}' limit 1").and_return(hashtag.id)
                response = hashtag.exist?
                
                expect(response).to eq(hashtag.id)
            end
        end
        
        context 'when not exist' do
            it 'respond nil' do
                hashtag = Hashtag.new
                hashtag.id = nil
                hashtag.name = '#newHashtag'

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("SELECT id FROM hashtags WHERE name = '#{hashtag.name}' limit 1").and_return(hashtag.id)
                response = hashtag.exist?
                
                expect(response).to eq(hashtag.id)
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

        context 'when valid' do
            it 'respond self object' do
                hashtag = Hashtag.new
                hashtag.id = 1
                hashtag.name = '#hashtag'

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from hashtags where id = '#{hashtag.id}'").and_return(hashtag)
                response = hashtag.find(hashtag.id)
                
                expect(response).to eq(hashtag)
            end
        end
    end

    describe '#update' do
        context 'when valid' do
            it 'respond true' do
                change_hashtag = Hashtag.new
                change_hashtag.name = '#newHashtag'

                hashtag = Hashtag.new
                hashtag.id = 1
                
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from hashtags where id = '#{hashtag.id}'").and_return(hashtag)
                expect(mock_client).to receive(:query).with("update hashtags set `name`= '#{change_hashtag.name}' where id = '#{hashtag.id}'").and_return(true)
                response = hashtag.find(1).update(change_hashtag)

                expect(response).to eq(true)
            end
        end
    end

    describe '#delete' do
        context 'when valid' do
            it 'respond true' do
                hashtag = Hashtag.new
                hashtag.id = 1
                
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from hashtags where id = '#{hashtag.id}'").and_return(hashtag)
                expect(mock_client).to receive(:query).with("delete from hashtags where id = '#{hashtag.id}'").and_return(true)
                response = hashtag.find(1).delete
                
                expect(response).to eq(true)
            end
        end
    end
    
    describe '#trending' do
        context 'when valid' do
            it 'respond hash of trending hashtag' do
                hashtag = Hashtag.new
                hashtags = [{
                    :id => 1,
                    :name => "#apa",
                    :created_at => "2021-08-21 21:58:35 +0700",
                    :updated_at => "2021-08-21 21:58:35 +0700"
                }]

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("SELECT * FROM hashtags WHERE created_at >= now() - INTERVAL 1 DAY;").and_return(hashtags)
                hashtag.trending
            end
        end
    end

    describe '#all' do
        context 'when valid' do
            it 'respond all object hashtag from databases' do
                hashtag = Hashtag.new
                
                hashtag_1 = Hashtag.new
                hashtag_1.name = '#hashtag1'
                
                hashtag_2 = Hashtag.new
                hashtag_2.name = '#hashtag2'
                
                hashtag_3 = Hashtag.new
                hashtag_3.name = '#hashtag3'

                hashtags = [hashtag_1, hashtag_2, hashtag_3]

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from hashtags").and_return(hashtags)
                hashtag.all
                
                hashtags.each_with_index do |hashtag, index|
                    expect(hashtag.name).to eq(hashtags[index].name)
                end
            end
        end
    end
end