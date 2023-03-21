class Group < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :expenses
end
