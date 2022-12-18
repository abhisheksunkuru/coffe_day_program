json.array! @items do |item|
  json.id item.id
  json.name item.name
  json.category item.category
  json.tax item.tax
  json.price item.price
end