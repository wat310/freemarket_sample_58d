class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :postal_code, null: false
      t.bigint :prefecture_id, null: false, foreign_key: true
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :building
      t.timestamps
    end
  end
end
