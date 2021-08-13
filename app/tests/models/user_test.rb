require_relative '../../models/user.rb'

describe User do
    describe '#validate' do
        before do
            @user = User.new
        end

        context 'when invavalid' do
            it 'respond false' do
                response = @user.valid?
                expect(false).to eq(response)
            end

            it 'respond false if email nil' do
                @user.username = 'edi'
                response = @user.valid?
                expect(false).to eq(response)
            end

            it 'respond false if username nil' do
                @user.email = 'edi@mail.co'
                response = @user.valid?
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond true' do
                @user.username = 'edi'
                @user.email = 'edi@mail.co'
                response = @user.valid?
                expect(true).to eq(response)
            end
        end
    end

    describe '#insert' do
        context 'when invalid' do
            it 'respond false' do
                user = User.new
                response = user.save 
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond true' do
                user = User.new
                user.username = "edi"
                user.email = "edi@mail.co"

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into users (username,email) values ('#{user.username}','#{user.email}')")
                user.save
            end
        end
    end

    describe '#find' do
        context 'when invalid' do
            it 'respond nil' do
                user = User.new
                user.id = 1
            
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from users where id = '#{user.id}'").and_return(nil)
                user.find(user.id)
            end
        end

        context 'when valid' do
            it 'respond self object' do
                user = User.new
                user.id = 1 
                user.username = 'edi'
                user.email = 'edi@mail.co'
            
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from users where id = '#{user.id}'").and_return(user)
                user.find(user.id)
            end
        end
    end

    describe '#update' do
        context 'when valid' do
            it 'respond true' do
                change_user = User.new
                change_user.username = 'edi'
                change_user.email = 'edi@mail.co'
                

                user = User.new
                user.id = 1
                
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from users where id = '#{user.id}'").and_return(user)
                expect(mock_client).to receive(:query).with("update user set `username`= '#{change_user.username}', `email` = '#{change_user.email}' where id = '#{user.id}'").and_return(true)
                user.find(1).update(change_user)
            end
        end
    end
end