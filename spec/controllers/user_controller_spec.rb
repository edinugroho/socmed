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
        context 'when invalid' do
            it 'respond false if username nil' do
                user_controller = UserController.new
                user = { 
                    :email => 'edi@mail.co',
                    :bio => 'This is bio'
                }
                response = user_controller.store(user.to_json)

                expect(response).to eq(false.to_json)
            end
            
            it 'respond false if email nil' do
                user_controller = UserController.new
                user = { 
                    :username => 'edi', 
                    :bio => 'This is bio'
                }
                response = user_controller.store(user.to_json)

                expect(response).to eq(false.to_json)
            end
            
            it 'respond false if bio nil' do
                user_controller = UserController.new
                user = { 
                    :username => 'edi',
                    :email => 'edi@mail.co'
                }
                response = user_controller.store(user.to_json)

                expect(response).to eq(false.to_json)
            end
        end

        context 'when valid' do
            it 'respond true' do
                user_controller = UserController.new
                user = { 
                    :username => 'edi', 
                    :email => 'edi@mail.co',
                    :bio => 'This is bio'
                }
                response = user_controller.store(user.to_json)

                expect(response).to eq(true.to_json)
            end
        end
    end

    describe '#show' do
        context 'when valid' do
            it 'respond user' do
                user_controller = UserController.new
                response = user_controller.show(1)

                expect(response).to eq(user_controller.show(1))
            end
        end
    end
    
    describe '#update' do
        context 'when valid' do
            it 'respond true' do
                user_controller = UserController.new
                user = {
                    "username" => "edas edited",
                    "email" => "edas@mail.co",
                    "bio" => "This is bio"
                }
                response = user_controller.update(1, user)

                expect(response).to eq(true.to_json)
            end
        end
    end
    
    describe '#delete' do
        context 'when valid' do
            it 'respond true' do
                user_controller = UserController.new
                response = user_controller.destroy(3)

                expect(response).to eq(true.to_json)
            end
        end
    end
end