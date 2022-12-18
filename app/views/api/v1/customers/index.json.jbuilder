json.array! @customers do |customer|
  json.name customer.name
  json.phone customer.phone
end