class RemovePleaseListAnHonorsOrAwardsFromApplications < ActiveRecord::Migration
  def up
  	remove_column :applications, :please_list_an_honors_or_awards
  	add_column :applications, :honors_or_awards, :text
  end

  def down
  	add_column :applications, :please_list_an_honors_or_awards, :text
  	remove_column :applications, :honors_or_awards
  end
end
