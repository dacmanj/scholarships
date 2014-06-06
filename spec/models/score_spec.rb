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

require 'spec_helper'

describe Score do
  pending "add some examples to (or delete) #{__FILE__}"
end
