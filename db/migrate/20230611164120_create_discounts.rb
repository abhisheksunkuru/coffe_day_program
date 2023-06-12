class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.integer :discounted_item_id
      t.float :discount_percentage
      t.integer :min_quantity
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
