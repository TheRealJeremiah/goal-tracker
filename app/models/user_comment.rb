class UserComment < ActiveRecord::Base
  validates :body, :user, presence: true
  belongs_to :user
end
