class Offer < ApplicationRecord

  validates :name, :purchased_item_ids, :free_item_ids, :purchased_item_min_quantity, presence: true

end
