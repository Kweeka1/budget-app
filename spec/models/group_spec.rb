require 'rails_helper'

describe 'Group' do

  let(:user1) { User.first }

  before do
    subject.save
  end

  subject do
    if user1.nil?
      user1 = User.create(name: 'Peter', email: 'peter@gmail.com', encrypted_password: '123456')
    end
    Group.new(name: 'School', icon: 'https://www.imgur.com/dA4D8aQ', author_id: user1.id)
  end

  context 'Model should be valid' do
    it 'Name should be present' do
      subject.name = nil
      expect(subject.valid?).to be false
    end

    it 'Icon should be present' do
      subject.icon = nil
      expect(subject.valid?).to be false
    end
  end
end
