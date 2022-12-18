class Api::V1::CustomersController < ActionController::API
  #respond_to :json

  def index
    @customers = Customer.all
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json:{message: "created successfully"},status: 200
    else
      render json:{message: "Something went wrong", errors: customer.errors},statu: 422
    end    
  end
  
  private 

  def customer_params
    params.require(:customer).permit(:name,:mobile)
  end  
end
