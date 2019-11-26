class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.datetime :discarded_at, after: :deleted

      t.timestamps
    end
    add_index :artists, :name
    add_index :artists, :discarded_at
  end
end
