class AddRefItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :category, foreign_key: true
    change_column_null :items, :category_id, nul: false
    add_reference :items, :brand, foreign_key: true
  end
end
