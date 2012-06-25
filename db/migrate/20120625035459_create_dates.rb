class CreateDates < ActiveRecord::Migration
  def up
    create_table :play_dates do |t|
      t.integer :play_id
      t.datetime :playtime
      t.float :price
    end
  end

  def down
    drop_table :play_dates
  end
end
