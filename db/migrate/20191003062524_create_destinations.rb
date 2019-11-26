class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :user_id, null: false
      t.string :address_name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
