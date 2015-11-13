class AddOutToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :out, :boolean, default: false
  end
end
