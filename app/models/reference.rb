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

class Reference < ActiveRecord::Base
  attr_accessible :application_id, :email, :how_long_have_you_known, :name, :phone_number, :references_essay, :relationship, :maturity, :leadership_ability, :self_confidence, :self_awareness, :intellectual_curiosity, :initiative, :adaptability, :personal_integrity, :respect_for_different_viewpoints
  belongs_to :application
  belongs_to :user
  before_save :downcase_email
  RATING_SCALE = [['Excellent',4],['Above Average',3],['Average',2], ['Below Average',1], ['Inadequate Opportunity to Observe',0]]
  RATINGS_HASH = {4=>"Excellent", 3=>"Above Average", 2=>"Average", 1=>"Below Average", 0=>"Inadequate Opportunity to Observe"}
  scope :completed, where("completed IS NOT NULL")
  def downcase_email
  	self.email = self.email.downcase
  end

  def token_url
    "/references/token/#{self.token}"
  end

end
