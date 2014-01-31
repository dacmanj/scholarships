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
#  essay                                           :text
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
#  applicant_user_id                               :integer
#

class Application < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :users
  has_many :scores
  has_many :references
  attr_accessible :transcript

  has_attached_file :transcript
  validates_attachment_content_type :transcript, :content_type => /^(application\/pdf|image\/(jpg|jpeg|pjpeg|png|x-png|gif|pdf|tif|tiff))$/, :message => 'file type is not allowed (only pdf/tif/jpeg/png/gif images)'

#  accepts_nested_attributes_for :user
  attr_accessible :name, :email, :applicant_user_id, :are_you_a_graduating_high_school_senior, :city, :cumulative_gpa, :date_of_birth, :date_of_graduation, :describe_community_service_activities, :essay, :how_did_you_learn_about_the_scholarship, :hs_city, :hs_state, :hs_street_address, :hs_zip, :identify_supporter, :identify_lgbt, :name_of_high_school, :out_and_open, :phone, :please_list_an_honors_or_awards, :please_lists_schools_where_you_will_be_applying, :reference_id, :release_essay_collection, :release_high_school, :release_local_chapter, :release_local_media, :release_national_media, :release_photograph, :release_picture_bio_on_website, :signature_ip, :signature_stamp, :state, :street_address, :supportive_parents, :user_id, :zip, :honors_or_awards, :stem, :major, :admission_status, :employment_history, :how_did_you_learn_explanation, :user_attributes
  ADMISSION_STATUS = ['Planning to apply', 'Waiting for reponse', 'Admitted']
  HOW_DID_YOU_LEARN_ABOUT_THE_SCHOLARSHIP = ['Internet (please provide url)', 'PFLAG Chapter (please list)', 'GSA', 'Counselor', 'Friend', 'Other (please list)', ]

  def self.find_by_uid(uid)
    Application.find_by_applicant_user_id(uid)
  end

  def applicant
    self.user
  end

  def user
    begin
      User.find(self.applicant_user_id) unless self.applicant_user_id.nil?
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def user=(value)
    self.applicant_user_id = value
  end

  def reviewers
    self.users.reject{|h| h.id == self.applicant_user_id}
  end

  def name
    self.applicant.name unless self.applicant.blank?
  end

  def email
    self.applicant.email unless self.applicant.blank?
  end


  def name=(value)
    u = self.applicant
    u.email = value
    u.save
  end
  def email=(value)
    u = self.applicant
    u.email = value
    u.save
  end

end
