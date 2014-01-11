class AddTokenToReference < ActiveRecord::Migration
  def change
    add_column :references, :token, :string
  end
end
