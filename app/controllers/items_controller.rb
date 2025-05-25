class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

   def new
    @item = Item.new
  end

   def create
    @item = Item.new(item_params)
    @item.user = current_user 

     if @item.save
      redirect_to root_path 
    else
      render :new 
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :category_id,
      :status_id,
      :shipping_fee_id,
      :prefecture_id,
      :delivery_day_id,
      :price
    )
  end
end
