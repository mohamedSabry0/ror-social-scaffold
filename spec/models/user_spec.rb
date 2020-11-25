require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(name: 'random', email: 'rand@example.com', password: '123456')
  it 'should have name present' do
    expect(user).to be_valid
  end

  it 'should have username' do
    expect(user).to be_valid
  end
end
