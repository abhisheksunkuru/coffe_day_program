json.array! @customers do |customer|
  json.name customer.name
  json.mobile customer.mobile
  json.id customer.id
end