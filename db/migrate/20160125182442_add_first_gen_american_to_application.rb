class AddFirstGenAmericanToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :first_generation_american, :boolean
  end
end
