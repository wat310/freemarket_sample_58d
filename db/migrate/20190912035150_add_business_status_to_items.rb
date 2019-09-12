class AddBusinessStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :business_status, :integer, null: false
    t.
  end
end
