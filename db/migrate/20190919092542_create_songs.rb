class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|

      t.integer :song_order, :null => false
      t.string :name, :null => false
      t.integer :disc_id, foreign_key: true, :null => false
      t.timestamps
    end
  end
end
