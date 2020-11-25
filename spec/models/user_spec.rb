require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(name: 'random', email: 'rand@example.com', password: '123456')
  it 'should have name present' do
    expect(user).to be_valid
  end

  it 'should have username' do
    expect(user).to be_valid
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).class_name('Friendship') }
  end
end
