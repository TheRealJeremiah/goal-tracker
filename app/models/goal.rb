class Goal < ActiveRecord::Base
  validates :title, :content, :user, :privacy, presence: true
  validates :privacy, inclusion: { in: ['public', 'private'] }

  belongs_to :user

  has_many :goal_comments
end
