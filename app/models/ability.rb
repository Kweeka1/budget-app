class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can(:manage, Group, user:)
    can(:manage, Expense, user:)
  end
end
