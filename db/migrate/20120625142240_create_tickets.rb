class CreateTickets < ActiveRecord::Migration
  def up
    create_table :tickets do |t|
      t.integer :play_date_id
      t.integer :user_id
      t.integer :count
      t.string :code
    end
  end

  def down
    drop_table :tickets
  end
end
