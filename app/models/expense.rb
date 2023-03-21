class Expense < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :groups
end
