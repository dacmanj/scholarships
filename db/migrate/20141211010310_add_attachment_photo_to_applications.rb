class AddAttachmentPhotoToApplications < ActiveRecord::Migration
  def self.up
    change_table :applications do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :applications, :photo
  end
end
