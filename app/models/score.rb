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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discretionary     :integer
#

class Score < ActiveRecord::Base
  resourcify
  belongs_to :user
  belongs_to :application
  attr_accessible :academics, :activities, :ally, :application_id, :community_college, :discretionary, :essay, :lgbt, :lgbt_advocacy, :stem, :user_id

  def normalized_score
	scores = [self.essay,self.academics,self.activities,self.lgbt_advocacy,self.discretionary]
  	multipliers = [6.0,4.0,3.0,5.0,4.0]
  	base = 22.0
  	sum = 0.0
  	i = 0 
  	scores.each do |score|
  	  sum += (score.to_d||0.0) * multipliers[i] / base
  	  i += 1
	end
	sum
  end
end
