# == Schema Information
#
# Table name: references
#
#  id                      :integer          not null, primary key
#  application_id          :integer
#  name                    :string(255)
#  email                   :string(255)
#  phone_number            :string(255)
#  how_long_have_you_known :string(255)
#  relationship            :text
#  references_essay        :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  completed               :datetime
#

require 'spec_helper'

describe Reference do
  pending "add some examples to (or delete) #{__FILE__}"
end
