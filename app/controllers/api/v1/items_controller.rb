class Api::V1::ItemsController < ActionController::API

  def index
    @items = Item.where("avaialable_quantity > ?",0).all
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json:{message: "item created successfully"},status: :ok
    else
      render json: {message: "something went wrog",errors: item.errors}, status: 422
    end
  end

  def show
    @item = Item.where(id: params[:id]).first
    unless @item.present?
      render json:{message: "item not found"}
    end
  end

  def update
    item = Item.where(params[:id]).first
    if item.present?
      if item.update(item_params)
        render json: {message: "item updated successfully"},status: :ok
      else
        render json: {message: "Item not updated", errors: item.errors},status: 422
      end
    else
      render json:{message: "item not found"}, status: 422
    end
  end

  def destroy
    item = Item.where(id: params[:id]).first
    if item.present?
      if item.destroy
        render json: {message: "item deleted successfully"},status: :ok
      else
        render json: {message: "Item not deleted", errors: item.errors},status: 422
      end
    else
      render json:{message: "item not found"}, status: 422
    end
  end

  def add_to_cart
    item = Item.where(id: params[:id]).first
    if params[:customer_id].present? && Customer.where(id: params[:customer_id]).last.present?  
      @cart = params[:quantity].present? ? item.add_to_cart(params[:customer_id], params[:quantity]) : item.add_to_cart(params[:customer_id])
      render template:"api/v1/carts/show"
    elsif params[:customer_id].present?
      render json: {error: "Customer not found"},status: 422
    else
      render json: {error: "customer is required"}, status: 422
    end
  end

  def remove_from_cart
    item = Item.where(id: params[:id]).first
    if params[:customer_id].present? && params[:quantity].present? && Customer.where(id: params[:customer_id]).last.present?
      @cart = item.remove_from_cart(params[:customer_id],params[:quantity])
      render template:"api/v1/carts/show"
    elsif params[:customer_id].present?
      render json: {error: "Customer not found"},status: 422
    else
      render json: {error: "customer is required"}, status: 422
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:category,:tax, :price,:avaialable_quantity)
  end
end
