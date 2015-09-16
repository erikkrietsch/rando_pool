class AddNumberToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :number, :integer
  end
end
