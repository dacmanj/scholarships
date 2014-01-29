# == Schema Information
#
# Table name: references
#
#  id                               :integer          not null, primary key
#  application_id                   :integer
#  name                             :string(255)
#  email                            :string(255)
#  phone_number                     :string(255)
#  how_long_have_you_known          :string(255)
#  relationship                     :text
#  references_essay                 :text
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  user_id                          :integer
#  completed                        :datetime
#  token                            :string(255)
#  maturity                         :integer
#  leadership_ability               :integer
#  self_confidence                  :integer
#  self_awareness                   :integer
#  intellectual_curiosity           :integer
#  initiative                       :integer
#  adaptability                     :integer
#  personal_integrity               :integer
#  respect_for_different_viewpoints :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    application_id 1
    name "MyString"
    email "MyString"
    phone_number "MyString"
    how_long_have_you_known "MyString"
    relationship "MyText"
    references_essay "MyText"
  end
end
