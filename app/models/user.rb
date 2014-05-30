# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ActiveRecord::Base
  rolify
  has_and_belongs_to_many :applications
  has_many :references
  has_many :scores
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:google_oauth2]

  after_create :default_role_and_create_blank_application

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name

  REVIEWERS = ['dcmanueljr@gmail.com','dtepfer@ameritech.net','sthoron@aol.com','swansj@gmail.com','dsanchez@pflag.org','jennifersavage@pflagtricities.org',
                'mosestorreblanca@gmail.com','katynelsen71@gmail.com','lynne_490@hotmail.com','madams4@hotmail.com','kt6565@yahoo.com','hrickerl1@gmail.com',
                'laurie.mayers@gmail.com','thom3308@msn.com','arthurfreeheart1@gmail.com','patpoynter@yahoo.com', 'sherrythompsonharrold@gmail.com', 'tamiekaufman@hotmail.com',
                'pflagyumasecretary@yahoo.com', 'cztwins@hotmail.com', 'hughes1985@hotmail.com', 'taramitchell@gmail.com']
                
  DEADLINE = Date::strptime("30-04-2014","%d-%m-%Y")

  def is?(role)
    self.has_role?(role)
  end
  
  def application
    if self.has_role? :student
      Application.find_by_uid(self.id)
    end
  end


  def incomplete_application?
    !@email.in? REVIEWERS and self.application.incomplete? unless self.application.blank?
  end

  def active_for_authentication?
    super and !(self.is? :student and Date.today > DEADLINE )
  end

  def inactive_message
    Date.today <= DEADLINE ? super : :deadline_has_already_passed
  end
  
  private
  def default_role_and_create_blank_application
    domain = /@(.+$)/.match(self.email)[1]
    admin = domain.casecmp("pflag.org") != 0 ? false : true
    reviewer = self.email.downcase.in? User::REVIEWERS 

    if reviewer
      remove_role :student
      add_role :reviewer
    elsif admin
      add_role :admin
    else
      add_role :student
      self.applications.push Application.new({:applicant_user_id => self.id})
    end 
  end
    
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20]
            )
    end
    user
  end

end
