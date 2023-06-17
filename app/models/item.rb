class Item < ApplicationRecord
  validates :name, :category, :avaialable_quantity, presence: true
  validates :tax, numericality: true
  validates :price, numericality: {greater_than: 0}
  validates :avaialable_quantity, numericality: {greater_than_or_equal_to: 0}
  has_and_belongs_to_many :discounts

  def add_to_cart(customer_id,quantity=1)
    #increment quantity if cart_item already exisits else create new cart item
    # customer = Customer.find(customer_id)
    # cart = customer.current_cart
    # cart_item = cart.cart_items.where(item_id: self.id).
    cart_item,cart = get_cart_item_for_customer(customer_id)

    if cart_item.present?
      cart_quantity = cart_item.quantity
      cart_item.update(quantity: quantity.to_i + cart_quantity)
    else
      cart.cart_items.create(item_id: id, cart_id: cart.id, quantity: quantity.to_i)
    end
    cart
  end

  def remove_from_cart(customer_id,quantity=1)
    cart_item,cart = get_cart_item_for_customer(customer_id)
    if cart_item.present? && cart_item.quantity > 0
      cart_quantity = cart_item.quantity
      quantity = quantity.to_i
      update_quantity = (quantity > cart_quantity ? 0 : cart_quantity-quantity)

      if update_quantity > 0
        cart_item.update(quantity: update_quantity)
      else

        cart_item.destroy
      end
    elsif cart_item.present?
      cart_item.destroy

    end
    cart
  end

  private

  def get_cart_item_for_customer(customer_id)
    customer = Customer.find(customer_id)
    cart = customer.current_cart
    cart_item = cart.cart_items.where(item_id: self.id).last
    return cart_item, cart
  end
end
