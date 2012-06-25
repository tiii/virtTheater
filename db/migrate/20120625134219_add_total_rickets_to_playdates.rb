class AddTotalRicketsToPlaydates < ActiveRecord::Migration
  class PlayDates < ActiveRecord::Base

  end
    
  def up
    add_column :play_dates, :ticket_count, :integer

    PlayDates.reset_column_information
    PlayDates.update_all("ticket_count = 10")
  end

  def down
    remove_column :play_dates, :ticket_count
  end
end
