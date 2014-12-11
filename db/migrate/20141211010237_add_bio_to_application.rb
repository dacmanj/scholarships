class AddBioToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :biography, :text
  end
end
