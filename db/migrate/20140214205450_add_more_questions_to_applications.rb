class AddMoreQuestionsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :first_generation, :boolean
    add_column :applications, :release_application_to_chapter, :boolean
    add_column :applications, :why_do_you_want, :text

  end
end
