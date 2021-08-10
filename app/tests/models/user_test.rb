require_relative '../../models/user.rb'

describe User do
    describe '#validate' do
        context 'when invavalid' do
            it 'respond false' do
                user = User.new
                response = user.valid?
                expect(false).to eq(response)
            end
        end
    end
end