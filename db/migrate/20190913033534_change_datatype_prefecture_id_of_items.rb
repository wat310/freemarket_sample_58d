class ChangeDatatypePrefectureIdOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :prefecture_id, :bigint, null: false, foreign_key: true
  end
end
