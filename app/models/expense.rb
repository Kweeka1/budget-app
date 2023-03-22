class Expense < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :groups, through: :expenses_groups

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0  }
end
