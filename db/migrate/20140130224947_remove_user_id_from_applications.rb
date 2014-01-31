class RemoveUserIdFromApplications < ActiveRecord::Migration
  def up
    remove_column :applications, :user_id
  end

  def down
    add_column :applications, :user_id, :integer
  end
end
