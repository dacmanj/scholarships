class AddTotalToScores < ActiveRecord::Migration
  def change
    add_column :scores, :total, :decimal
  end
end
