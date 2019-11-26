class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.integer :user_id, foreign_key: true, null: false
      t.integer :product_id, foreign_key: true, null: false
      t.text :review
      t.timestamps
    end
  end
end
