class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.references :customer
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end
end
