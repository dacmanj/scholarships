class RemoveReferenceIdFromApplication < ActiveRecord::Migration
  def up
    remove_column :applications, :reference_id
  end

  def down
    add_column :applications, :reference_id, :string
  end
end
