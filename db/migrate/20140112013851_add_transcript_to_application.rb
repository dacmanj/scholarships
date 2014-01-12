class AddTranscriptToApplication < ActiveRecord::Migration
  def self.up
    add_attachment :applications, :transcript
  end

  def self.down
    remove_attachment :applications, :transcript
  end
end
