class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.integer :price, null: false, index:true
      t.text :explanation, null: false
      # t.references :user, null: false, foreign_key: true
      t.bigint :user_id, null: false, foreign_key: true
      # t.references :category, null: false, foreign_key: true
      # t.references :brand, foreign_key: true
      t.integer :size
      t.integer :state, null: false
      t.integer :postage, null: false
      t.integer :shipping_method, null: false
      t.integer :region, null: false
      t.integer :shipping_date, null: false
      # t.references :buyer, foreign_key: true,  to_table: :users
      t.bigint :buyer_id, foreign_key: true, to_table: :users
      t.timestamps
    end
  end
end
