# frozen_string_literal: true

class DeviseCreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :family_name_kanji, null: false
      t.string :first_name_kanji, null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana, null: false
      t.date :birthday, null: false
      t.string :phone_number, null: false, unique: true
      t.text :message
      t.integer :evaluation_good, null: false
      t.integer :evaluation_normal, null: false
      t.integer :evaluation_bad, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end