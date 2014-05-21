class AddAdvCommentToScores < ActiveRecord::Migration
  def change
    add_column :scores, :lgbt_advocacy_comment, :text
  end
end
