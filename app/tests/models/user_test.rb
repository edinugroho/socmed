require_relative '../../models/user.rb'

describe User do
    describe '#validate' do
        context 'when invavalid' do
            it 'respond false' do
                user = User.new
                response = user.valid?
                expect(false).to eq(response)
            end

            it 'respond false if email nil' do
                user = User.new
                user.username = 'edi'
                response = user.valid?
                expect(false).to eq(response)
            end
        end
    end
end