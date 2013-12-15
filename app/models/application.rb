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
#  indentify_lgbt                                  :boolean
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
#

class Application < ActiveRecord::Base
  attr_accessible :are_you_a_graduating_high_school_senior, :city, :cumulative_gpa, :date_of_birth, :date_of_graduation, :describe_community_service_activities, :essay, :how_did_you_learn_about_the_scholarship, :hs_city, :hs_state, :hs_street_address, :hs_zip, :identify_supporter, :indentify_lgbt, :name_of_high_school, :out_and_open, :phone, :please_list_an_honors_or_awards, :please_lists_schools_where_you_will_be_applying, :reference_id, :release_essay_collection, :release_high_school, :release_local_chapter, :release_local_media, :release_national_media, :release_photograph, :release_picture_bio_on_website, :signature_ip, :signature_stamp, :state, :street_address, :supportive_parents, :user_id, :zip
end