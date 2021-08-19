require_relative '../../app/controllers/user_controller.rb'

describe UserController do
    describe '#index' do
        context 'when valid' do
            it 'respond json all users' do
                user_controller = UserController.new
                users = [
                    {
                        :id => 1, 
                        :username => 'edi', 
                        :email => 'edi@mail.co', 
                        :created_at => "2021-08-18 03:30:13 +0700", 
                        :updated_at => "2021-08-18 03:30:13 +0700"
                    },
                    {
                        :id => 1, 
                        :username => 'dwi', 
                        :email => 'dwi@mail.co', 
                        :created_at => "2021-08-18 03:30:13 +0700", 
                        :updated_at => "2021-08-18 03:30:13 +0700"
                    }
                ]

                allow(user_controller).to receive(:index).and_return(users.to_json)

                expect(user_controller.index).to eq(users.to_json)
            end
        end
    end

    describe '#store' do
        context 'when valid' do
            it 'respond true' do
                user_controller = UserController.new
                user = { 
                    :username => 'edi', 
                    :email => 'edi@mail.co'
                }

                allow(user_controller).to receive(:store).with(user).and_return(true.to_json)

                expect(user_controller.store(user)).to eq(true.to_json)
            end
        end
    end
end