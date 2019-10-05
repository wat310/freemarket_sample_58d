class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :shipping_family_name_kanji, :string
    add_column :users, :shipping_first_name_kanji, :string
    add_column :users, :shipping_family_name_kana, :string
    add_column :users, :shipping_first_name_kana, :string
  end
end
