require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Peter', email: 'peter@gmail.com', encrypted_password: '123456')
  end

  before { subject.save }

  context 'Model should be valid' do
    it 'Name should be present' do
      subject.name = nil
      expect(subject.valid?).to be false
    end

    it 'Email should be present' do
      subject.email = nil
      expect(subject.valid?).to be false
    end

    it 'Password should be present' do
      subject.encrypted_password = nil
      expect(subject.valid?).to be false
    end
  end
end
