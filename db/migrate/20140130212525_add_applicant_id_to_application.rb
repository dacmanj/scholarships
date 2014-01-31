class AddApplicantIdToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :applicant_user_id, :integer
  end
end
