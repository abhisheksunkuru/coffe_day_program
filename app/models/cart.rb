class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items, dependent: :destroy

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
end
