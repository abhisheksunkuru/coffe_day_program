class Customer < ApplicationRecord

  #fields
  #name type:String
  #mobile type:Integer
  validates :name, presence: true
  validates :mobile, presence: {message: "badd operations, only numbers accepted"},
    numericality: true, length: {minimum: 10, maximum: 12}

  has_many :carts

  def current_cart
    carts.where(status: "not_paid").last || carts.create(status: "not_paid")
  end
end
