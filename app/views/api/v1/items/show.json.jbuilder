if @item.present?
  json.name @item.name
  json.category @item.category
  json.price @item.price
  json.tax @item.tax
end