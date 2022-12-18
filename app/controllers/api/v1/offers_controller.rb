class Api::V1::OffersController < ActionController::API

  def index
    @offers = Offer.all
  end

  def create
    offer = Offer.new(offer_params)
    if offer.save
      render json: {message: "offer created successfully"}
    else
      render json:{message: "something went wrong"}
    end
  end

  def show
    @offer = Offer.where(id: params[:id]).first
    unless @offer.present?
      render json:{error: "offer not found"}
    end
  end

  def update
    @offer = Offer.where(id: params[:id]).first
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
    params.require(:offer).permit(:name, :purchased_item_min_quantity, :free_item_quantities, :free_item_discount, purchased_item_ids:[], free_item_ids:[])
  end

end
