class Group < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :expenses, through: :expenses_groups

  validates :name, presence: true
  validates :icon, presence: true
end
