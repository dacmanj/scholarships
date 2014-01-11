class AddCompletedToReference < ActiveRecord::Migration
  def change
    add_column :references, :completed, :datetime
  end
end
