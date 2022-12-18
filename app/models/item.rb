class Item < ApplicationRecord
  validates :name, :category, :avaialable_quantity, presence: true
  validates :tax, numericality: true
  validates :price, numericality: {greater_than: 0}
  validates :avaialable_quantity, numericality: {greater_than_or_equal_to: 0}
end
