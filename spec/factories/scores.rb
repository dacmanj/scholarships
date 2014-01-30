# == Schema Information
#
# Table name: scores
#
#  id                :integer          not null, primary key
#  application_id    :integer
#  user_id           :integer
#  lgbt              :boolean
#  ally              :boolean
#  stem              :boolean
#  community_college :boolean
#  essay             :integer
#  academics         :integer
#  activities        :integer
#  lgbt_advocacy     :integer
#  discretionary     :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    application_id 1
    user_id 1
    lgbt false
    ally false
    stem false
    community_college ""
    essay 1
    academics 1
    activities 1
    lgbt_advocacy 1
    discretionary false
  end
end
