class ChangeDiscretionaryToIntegerInScores < ActiveRecord::Migration
  def up
  	remove_column :scores, :discretionary
  	add_column :scores, :discretionary, :integer

  end

  def down
  	remove_column :scores, :discretionary
  	add_column :scores, :discretionary, :boolean
  end
end
