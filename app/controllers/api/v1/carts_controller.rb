class Api::V1::CartsController < ActionController::API

  def index
    customer = Customer.where(id: params[:customer_id]).last
    if customer.present?
      @carts = customer.carts
    else
      render json: { message: "customer not found"}
    end
  end
end
