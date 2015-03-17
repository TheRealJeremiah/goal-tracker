class GoalComment < ActiveRecord::Base
  validates :body, :goal, presence: true
  belongs_to :goal
end
