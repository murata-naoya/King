class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name
      t.datetime :discarded_at, after: :deleted

      t.timestamps
    end
    add_index :labels, :name
    add_index :labels, :discarded_at
  end
end
