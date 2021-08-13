require_relative '../../models/post.rb'

describe 'Post' do
    describe '#validate' do
        before do
            @post = Post.new
        end

        context 'when invalid' do
            it 'respond false' do
                response = @post.valid?
                expect(false).to eq(response)
            end
        end
    end
end