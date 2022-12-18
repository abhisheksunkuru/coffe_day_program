class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.string :name
      t.integer :purchased_item_ids,array: true,default: []
      t.integer :free_item_ids,array: true,default: []
      t.integer :purchased_item_min_quantity
      t.integer :free_item_quantities
      t.integer :free_item_discount

      t.timestamps
    end
  end
end
