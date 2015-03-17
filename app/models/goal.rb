# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  privacy    :string
#

class Goal < ActiveRecord::Base
  validates :title, :content, :user, :privacy, presence: true
  validates :privacy, inclusion: { in: ['public', 'private'] }

  belongs_to :user
  has_many :comments, as: :commentable
end
