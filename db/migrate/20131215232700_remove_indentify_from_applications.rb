class RemoveIndentifyFromApplications < ActiveRecord::Migration
  def up
  	remove_column :applications, :indentify_lgbt
  	add_column :applications, :identify_lgbt, :boolean
  end

  def down
  	add_column :applications, :indentify_lgbt, :boolea
  	remove_column :applications, :identify_lgbt
  end
end