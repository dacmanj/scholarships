class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :application_id
      t.integer :user_id
      t.boolean :lgbt
      t.boolean :ally
      t.boolean :stem
      t.boolean :community_college
      t.integer :essay
      t.integer :academics
      t.integer :activities
      t.integer :lgbt_advocacy
      t.boolean :discretionary

      t.timestamps
    end
  end
end
