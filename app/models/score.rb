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

  WEIGHTS = { :essay => 6.0, :reference => 3.0, :academics => 4.0, :activities => 3.0, :lgbt_advocacy => 5.0, :discretionary => 4.0  }
  BASE = Score::WEIGHTS.map{|k,v| v}.inject(:+) #sum of the values of the above
  MULTIPLIERS = {}
  Score::WEIGHTS.each{|k,v| MULTIPLIERS[k] = v/BASE}

  def normalized_score
    base = 0
    score = 0

  	Score::MULTIPLIERS.each do |k,v|
  	  score += (self[k].to_d || 0.0) * v
  	end
	 score
  end

  def raw_score
    score = 0
    Score::MULTIPLIERS.each do |k,v|
      score += (self[k].to_d || 0.0)
    end
   score

  end

  protected
	def set_total
		self.total = normalized_score
	end

end
