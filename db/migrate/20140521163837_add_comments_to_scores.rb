class AddCommentsToScores < ActiveRecord::Migration
  def change
    add_column :scores, :essay_comment, :text
    add_column :scores, :academics_comment, :text
    add_column :scores, :activities_comment, :text
    add_column :scores, :lgbt_advocacy_comments, :text
    add_column :scores, :discretionary_comments, :text
    add_column :scores, :reference_comments, :text
    add_column :scores, :reference, :integer
  end
end
