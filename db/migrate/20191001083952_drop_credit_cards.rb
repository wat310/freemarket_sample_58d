class DropCreditCards < ActiveRecord::Migration[5.2]
  def change
    drop_table :credit_cards
  end
end
