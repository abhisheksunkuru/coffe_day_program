if @cart.present?

  json.items @cart.cart_items do |cart_item|
    json.item_id cart_item.item.id
    json.item_name cart_item.item.name
    json.category cart_item.item.category
    json.quantity cart_item.quantity
    json.unit_price cart_item.item.price
    json.tax cart_item.item.tax
  end
  json.amount @cart.amount
  json.status @cart.status
  json.discount_amount @cart.discount_amount
end