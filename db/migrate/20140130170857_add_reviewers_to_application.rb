class AddReviewersToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :reviewers, :string
  end
end
