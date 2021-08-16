require_relative '../../app/models/user.rb'

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
            
            it 'respond false if bio nil' do
                @user.bio = 'This is bio'
                response = @user.valid?
                expect(false).to eq(response)
            end
        end

        context 'when valid' do
            it 'respond true' do
                @user.username = 'edi'
                @user.email = 'edi@mail.co'
                @user.bio = 'This is bio'
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
                user.bio = "This is bio"

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("insert into users (username,email,bio) values ('#{user.username}','#{user.email}','#{user.bio}')")
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
                expect(mock_client).to receive(:query).with("update users set `username`= '#{change_user.username}', `email` = '#{change_user.email}' where id = '#{user.id}'").and_return(true)
                user.find(1).update(change_user)
            end
        end
    end

    describe '#delete' do
        context 'when valid' do
            it 'respond true' do
                user = User.new
                user.id = 1
                
                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from users where id = '#{user.id}'").and_return(user)
                expect(mock_client).to receive(:query).with("delete from users where id = '#{user.id}'").and_return(true)
                user.find(1).delete
            end
        end
    end

    describe '#all' do
        context 'when valid' do
            it 'respond all object user from databases' do
                user = User.new
                
                user_1 = User.new
                user_1.username = 'edi'
                user_1.email = 'edi@mail.co'
                user_1.bio = 'This is edi bio'
                
                user_2 = User.new
                user_2.username = 'dwi'
                user_2.email = 'dwi@mail.co'
                user_2.bio = 'This is dwi bio'
                
                user_3 = User.new
                user_3.username = 'nugroho'
                user_3.email = 'nugroho@mail.co'
                user_3.bio = 'This is nugroho bio'

                users = [user_1, user_2, user_3]

                mock_client = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_client)
                expect(mock_client).to receive(:query).with("select * from users").and_return(users)
                user.all
                
                users.each_with_index do |user, index|
                    expect(user.username).to eq(users[index].username)
                    expect(user.email).to eq(users[index].email)
                    expect(user.bio).to eq(users[index].bio)
                end
            end
        end
    end
end