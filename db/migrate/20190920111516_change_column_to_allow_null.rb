class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :stock,:string,  null: true
    change_column :products, :sold_at,:string,  null: true # null: trueを明示する必要がある
    change_column :products, :sell_status,:string,  null: true
    change_column :discs, :cd_count,:integer,  null: true
    change_column :songs, :song_order,:integer,  null: true
  end

  def down
    change_column :products, :stock, :string, null: false
    change_column :products, :sold_at, :string, null: false
    change_column :products, :sell_status,:string,  null: false
    change_column :discs, :cd_count,:integer,  null: false
    change_column :songs, :song_order,:integer,  null: false
  end
end
