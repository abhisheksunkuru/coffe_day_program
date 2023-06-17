class AddDiscountAmountToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :discount_amount, :float, default: 0.0
  end
end
