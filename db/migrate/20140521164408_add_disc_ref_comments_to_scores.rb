class AddDiscRefCommentsToScores < ActiveRecord::Migration
  def change
    add_column :scores, :discretionary_comment, :text
    add_column :scores, :reference_comment, :text
  end
end
