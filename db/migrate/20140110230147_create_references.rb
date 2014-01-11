class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :application_id
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :how_long_have_you_known
      t.text :relationship
      t.text :references_essay

      t.timestamps
    end
  end
end
