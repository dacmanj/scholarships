class AddEmploymentToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :employment_history, :text
  end
end
