class AddImageToSports < ActiveRecord::Migration
  def change
    add_column :sports, :image_id, :string
  end
end
