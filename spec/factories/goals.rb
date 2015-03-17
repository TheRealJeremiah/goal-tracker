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

FactoryGirl.define do
  factory :goal do
    content "goal's content"
    title "goal's title"
    privacy "public"
    user_id 1
  end

end
