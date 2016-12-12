class AddAttachmentAvatarToSports < ActiveRecord::Migration
  def self.up
    change_table :sports do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :sports, :avatar
  end
end
