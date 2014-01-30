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

require 'spec_helper'

describe Score do
  pending "add some examples to (or delete) #{__FILE__}"
end
