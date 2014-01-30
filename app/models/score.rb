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

class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :application
  attr_accessible :academics, :activities, :ally, :application_id, :community_college, :discretionary, :essay, :lgbt, :lgbt_advocacy, :stem, :user_id
end
