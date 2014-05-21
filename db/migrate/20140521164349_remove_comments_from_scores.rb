class RemoveCommentsFromScores < ActiveRecord::Migration
  def up
    remove_column :scores, :discretionary_comments
    remove_column :scores, :reference_comments
  end

  def down
    add_column :scores, :reference_comments, :string
    add_column :scores, :discretionary_comments, :string
  end
end
