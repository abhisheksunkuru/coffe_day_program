class Api::V1::DiscountsController < ActionController::API

  def index
    @offers = Discount.all
  end

  def create
    offer = Discount.new(offer_params)
    if offer.save
      render json: {message: "offer created successfully"}
    else
      render json:{message: "something went wrong"}
    end
  end

  def show
    @offer = Discount.where(id: params[:id]).first
    unless @offer.present?
      render json:{error: "offer not found"}
    end
  end

  def update
    @offer = Discount.where(id: params[:id]).first
    if @offer.present? && @offer.update(offer_params)
      render json: {message: "updated successfully"},status: :ok
    elsif @offer.present?
      render json: {errors: @offer.errors},status: 422
    else
      render json: {error: "offer not found"}
    end
  end

  private

  def offer_params
    params.require(:discount).permit(:id, :discounted_item_id, :discount_percentages, :min_quantity,:start_date, :end_date)
  end

end
