class CreateDiscs < ActiveRecord::Migration[5.2]
  def change
    create_table :discs do |t|

      t.integer :product_id, foreign_key: true, :null => false
      t.integer :cd_count, :null => false
      t.timestamps
    end
  end
end
