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

class Score < ActiveRecord::Base
  resourcify
  belongs_to :user
  belongs_to :application
  attr_accessible :academics, :activities, :ally, :application_id, :community_college, :discretionary, :essay, :lgbt, :lgbt_advocacy, :reference, :essay_comment, :academics_comment, :activities_comment, :lgbt_advocacy_comment, :discretionary_comment, :reference_comment, :stem, :user_id
  before_save :set_total

  def normalized_score
	scores = [self.essay,self.reference,self.academics,self.activities,self.lgbt_advocacy,self.discretionary]
  	multipliers = [6.0,3.0,4.0,3.0,5.0,4.0]
  	base = 25.0
  	sum = 0.0
  	i = 0 
  	scores.each do |score|
  	  sum += (score.to_d||0.0) * multipliers[i] / base
  	  i += 1
	end
	sum
  end

  protected
	def set_total
		self.total = normalized_score
	end

end
