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
    end
end