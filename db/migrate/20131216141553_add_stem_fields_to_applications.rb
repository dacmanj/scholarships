class AddStemFieldsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :stem, :boolean
    add_column :applications, :major, :string
    add_column :applications, :admission_status, :string
  end
end
