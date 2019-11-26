class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :user_id, null: false
      t.integer :total_count, null: false
      t.integer :total_price, null: false
      t.integer :delivery_status, null: false
      t.integer :option, null: false
      t.string :address_name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.timestamps
    end
  end
end
