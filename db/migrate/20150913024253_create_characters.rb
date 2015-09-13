class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.belongs_to :player
      t.belongs_to :season
      t.string :name

      t.timestamps
    end
  end
end
