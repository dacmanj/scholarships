class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.string :phone
      t.date :date_of_birth
      t.date :date_of_graduation
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :are_you_a_graduating_high_school_senior
      t.boolean :indentify_lgbt
      t.boolean :out_and_open
      t.boolean :identify_supporter
      t.boolean :supportive_parents
      t.string :how_did_you_learn_about_the_scholarship
      t.string :name_of_high_school
      t.string :hs_street_address
      t.string :hs_city
      t.string :hs_state
      t.string :hs_zip
      t.string :cumulative_gpa
      t.text :please_list_an_honors_or_awards
      t.text :please_lists_schools_where_you_will_be_applying
      t.text :describe_community_service_activities
      t.string :essay
      t.boolean :release_high_school
      t.boolean :release_local_media
      t.boolean :release_national_media
      t.boolean :release_local_chapter
      t.boolean :release_photograph
      t.boolean :release_essay_collection
      t.boolean :release_picture_bio_on_website
      t.integer :reference_id
      t.datetime :signature_stamp
      t.string :signature_ip

      t.timestamps
    end
  end
end
