class AddHowDidYouLearnExplanationToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :how_did_you_learn_explanation, :string
  end
end
