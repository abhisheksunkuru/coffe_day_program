class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items, dependent: :destroy
  
  after_update :check_offers

  def buy_x_get_y_offers
    item_ids = cart_items.map{|ci|ci.item.id}
    offer = Offer.where(purchased_item_ids: item_ids).last
    cart_items = cart_items.select{|ci| ci.id.in?(offer.purchased_item_ids) && ci.quantity >= offer.purchased_item_min_quantity}
    cart_items.each do |cart_item|
      item_quntity = cart_quantity/offer.purchased_item_min_quantity
      item_quntity.times do
        cart_item.create(item_id: offer.purchased_item_ids.first,price: 0, quantity: offer.free_item_quantities)
      end
    end
  end

  private

  def check_offers
    total_discount = 0
    item_ids = cart_items.map(&:item_id)
    cart_items.each do |cart_item|
      debugger
      discounts = cart_item.item.discounts.where(["min_quantity <= ?",cart_item.quantity])
      if discounts.present?
        discounts.each do |discount|
          if item_ids.include?(discount.discounted_item_id)
            discount_item = cart_items.where(item_id: discount.discounted_item_id).last
            quantity = discount_item&.quantity rescue 0
            price = quantity*(discount_item.item.price)
            total_discount += (price.to_f*(discount.discount_percentage/100)) 
          end    
        end  
      end  
    end  
    self.update_column(:discount_amount, total_discount)
  end  
end
