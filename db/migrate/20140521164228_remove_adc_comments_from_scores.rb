class RemoveAdcCommentsFromScores < ActiveRecord::Migration
  def up
    remove_column :scores, :lgbt_advocacy_comments
  end

  def down
    add_column :scores, :lgbt_advocacy_comments, :string
  end
end
