class CreateArrivals < ActiveRecord::Migration[5.2]
  def change
    create_table :arrivals do |t|

      t.integer :product_id, foreign_key: true, :null => false
      t.integer :arrival_count, :null => false
      t.datetime :arrival_date, :null => false
      t.timestamps
    end
  end
end
