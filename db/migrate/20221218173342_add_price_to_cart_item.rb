class AddPriceToCartItem < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :price, :integer
  end
end
