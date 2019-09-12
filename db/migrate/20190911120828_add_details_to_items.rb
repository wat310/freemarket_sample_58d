class AddDetailsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category_id, :bigint, null: false, foreign_key: true
    add_column :items, :brand_id, :bigint, foreign_key: true
  end
end
