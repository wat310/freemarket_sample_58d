class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.text :image, null: false
      t.bigint :item_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
