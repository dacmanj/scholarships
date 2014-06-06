# == Schema Information
#
# Table name: scores
#
#  id                    :integer          not null, primary key
#  application_id        :integer
#  user_id               :integer
#  lgbt                  :boolean
#  ally                  :boolean
#  stem                  :boolean
#  community_college     :boolean
#  essay                 :integer
#  academics             :integer
#  activities            :integer
#  lgbt_advocacy         :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  discretionary         :integer
#  total                 :decimal(, )
#  essay_comment         :text
#  academics_comment     :text
#  activities_comment    :text
#  reference             :integer
#  lgbt_advocacy_comment :text
#  discretionary_comment :text
#  reference_comment     :text
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
