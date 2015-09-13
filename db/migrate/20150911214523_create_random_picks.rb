class CreateRandomPicks < ActiveRecord::Migration
  def change
    create_table :random_picks do |t|
      t.belongs_to :week
      t.belongs_to :team
      t.timestamps
    end
  end
end
