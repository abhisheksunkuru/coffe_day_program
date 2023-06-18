class Api::V1::OrdersController < ActionController::API

  def create
    if params[:cart_id].present?
      cart = Cart.find(params[:cart_id])
      @order = Order.new(cart_id: cart.id, total: cart.amount, status: "confirmed")
      if @order.save
        cart.cart_items.each do |cart_item|
          @order.order_items.create(item_id: cart_item.item_id, quantity: cart_item.quantity)
        end
        render action: 'show'
      else
        render json:{message: @order.errors, status: 422}
      end    
    else
      render json:{message: "Cart is manadatory", status: 422}
    end  
  end
  
  def show
    @order = Order.where(id: params[:id]).last
    unless @order.present?
      render json: {message: "Ordernot found", status: 422}
    end  
  end

  def update
    @order = Order.find(params[:id])
    
    if @order.update(order_params)
      #NotifcationMailer.notify_order_completion(order) if order.status == "ready"
      render action: 'show'
    else
      render json: {errors: order.errors.to_json, status: 422}  
    end  
  end  
  
  private

  def order_params
    params.require(:order).permit(:id, :status, :total,:cart_id)
  end  

    
end
