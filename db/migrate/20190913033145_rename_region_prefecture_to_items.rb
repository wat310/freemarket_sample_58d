class RenameRegionPrefectureToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :region, :prefecture_id
  end
end
