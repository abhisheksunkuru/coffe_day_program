class CreateJoinTableItemsDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_join_table :items, :discounts do |t|
      # t.index [:item_id, :discount_id]
      # t.index [:discount_id, :item_id]
    end
  end
end
