class CreateApplicationsUsers < ActiveRecord::Migration
  def change
    create_table :applications_users do |t|
      t.integer :application_id
      t.integer :user_id
    end
  end
end
