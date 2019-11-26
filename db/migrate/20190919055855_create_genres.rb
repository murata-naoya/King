class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name
      t.datetime :discarded_at, after: :deleted

      t.timestamps
    end
    add_index :genres, :name
    add_index :genres, :discarded_at
  end
end
