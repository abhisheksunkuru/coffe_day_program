class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  after_create :update_cart_total
  after_update :update_cart_total
  after_destroy :update_cart_total

  private

  def update_cart_total
    total_price = 0
    
    CartItem.where(cart_id: self.cart_id).each do |cart_item|
      item = cart_item.item
      item_price_without_tax = (cart_item.quantity * item.price)
      tax_price = item_price_without_tax*(item.tax/100)
      total_price += (item_price_without_tax + tax_price)
    end  
    self.cart.update(amount: total_price)
  end  
end
