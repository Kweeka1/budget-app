require 'rails_helper'

RSpec.describe Expense, type: :model do

  let(:user1) { User.first }

  subject do
    if user1.nil?
      user1 = User.create(name: 'Peter', email: 'peter@gmail.com', encrypted_password: '123456')
    end

    Expense.new(name: 'Books', amount: 33.99, author_id: user1.id)
  end

  before { subject.save }

  context 'Model should be valid' do
    it 'Name should be present' do
      subject.name = nil
      expect(subject.valid?).to be false
    end

    it 'Amount should be present' do
      subject.amount = nil
      expect(subject.valid?).to be false
    end
  end
end
