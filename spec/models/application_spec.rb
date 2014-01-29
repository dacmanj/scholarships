# == Schema Information
#
# Table name: applications
#
#  id                                              :integer          not null, primary key
#  user_id                                         :integer
#  phone                                           :string(255)
#  date_of_birth                                   :date
#  date_of_graduation                              :date
#  street_address                                  :string(255)
#  city                                            :string(255)
#  state                                           :string(255)
#  zip                                             :string(255)
#  are_you_a_graduating_high_school_senior         :boolean
#  out_and_open                                    :boolean
#  identify_supporter                              :boolean
#  supportive_parents                              :boolean
#  how_did_you_learn_about_the_scholarship         :string(255)
#  name_of_high_school                             :string(255)
#  hs_street_address                               :string(255)
#  hs_city                                         :string(255)
#  hs_state                                        :string(255)
#  hs_zip                                          :string(255)
#  cumulative_gpa                                  :string(255)
#  please_lists_schools_where_you_will_be_applying :text
#  describe_community_service_activities           :text
#  essay                                           :string(255)
#  release_high_school                             :boolean
#  release_local_media                             :boolean
#  release_national_media                          :boolean
#  release_local_chapter                           :boolean
#  release_photograph                              :boolean
#  release_essay_collection                        :boolean
#  release_picture_bio_on_website                  :boolean
#  reference_id                                    :integer
#  signature_stamp                                 :datetime
#  signature_ip                                    :string(255)
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#  honors_or_awards                                :text
#  identify_lgbt                                   :boolean
#  stem                                            :boolean
#  major                                           :string(255)
#  admission_status                                :string(255)
#  employment_history                              :text
#  how_did_you_learn_explanation                   :string(255)
#  transcript_file_name                            :string(255)
#  transcript_content_type                         :string(255)
#  transcript_file_size                            :integer
#  transcript_updated_at                           :datetime
#

require 'spec_helper'

describe Application do
  pending "add some examples to (or delete) #{__FILE__}"
end
