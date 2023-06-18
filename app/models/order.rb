class Order < ApplicationRecord
  belongs_to :cart
  has_many :order_items, dependent: :destroy
end
