class AddFieldsToReference < ActiveRecord::Migration
  def change
    add_column :references, :maturity, :integer
    add_column :references, :leadership_ability, :integer
    add_column :references, :self_confidence, :integer
    add_column :references, :self_awareness, :integer
    add_column :references, :intellectual_curiosity, :integer
    add_column :references, :initiative, :integer
    add_column :references, :adaptability, :integer
    add_column :references, :personal_integrity, :integer
    add_column :references, :respect_for_different_viewpoints, :integer
  end
end
