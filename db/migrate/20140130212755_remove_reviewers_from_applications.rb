class RemoveReviewersFromApplications < ActiveRecord::Migration
  def up
    remove_column :applications, :reviewers
  end

  def down
    add_column :applications, :reviewers, :string
  end
end
