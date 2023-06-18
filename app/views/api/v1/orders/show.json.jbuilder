if @order.present?
  json.id @order.id
  json.status @order.status
  json.items @order.order_items do |order_item|
    json.item_id order_item.item_id
    json.quantity order_item.quantity
  end
end