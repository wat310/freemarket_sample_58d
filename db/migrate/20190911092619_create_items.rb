class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.integer :price, null: false, index:true
      t.text :explanation, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :size
      t.integer :state, null: false
      t.integer :postage, null: false
      t.integer :shipping_method, null: false
      # t.bigint :prefecture_id, null: false, foreign_key: true
      t.integer :prefecture_id, null: false
      t.integer :shipping_date, null: false
      t.integer :business_status, null: false, default: 0
      # t.bigint :buyer_id, foreign_key: true, to_table: :users
      t.integer :buyer_id, to_table: :users
      t.timestamps
    end
  end
end
