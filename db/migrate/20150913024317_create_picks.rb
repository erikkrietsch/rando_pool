class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.belongs_to :character
      t.belongs_to :week
      t.belongs_to :team

      t.timestamps
    end
  end
end
