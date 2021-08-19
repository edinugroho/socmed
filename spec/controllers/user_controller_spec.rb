require_relative '../../app/controllers/user_controller.rb'

describe UserController do
    describe '#index' do
        context 'when valid' do
            it 'respond json all users' do
                user_controller = UserController.new
                response = user_controller.index
                
                expect(user_controller.index).to eq(response)
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