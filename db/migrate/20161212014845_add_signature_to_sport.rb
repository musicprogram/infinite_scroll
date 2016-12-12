class AddSignatureToSport < ActiveRecord::Migration
  def change
    add_column :sports, :signature, :string
  end
end
