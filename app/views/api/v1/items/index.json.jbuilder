json.array! @items do |item|
  json.name item.name
  json.category item.category
  json.tax item.tax
  json.price item.price
end