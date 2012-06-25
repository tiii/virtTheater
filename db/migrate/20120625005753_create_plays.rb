class CreatePlays < ActiveRecord::Migration
  def up
    create_table :plays do |t|
      t.string :title
      t.text :description
      t.binary :picture
    end
  end

  def down
    drop_table :plays
  end
end
