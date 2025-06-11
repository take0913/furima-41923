class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_seller, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
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

def show
end

def edit
  redirect_to root_path unless current_user == @item.user
end

def update
  if @item.update(item_params)
    redirect_to item_path(@item)
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  return redirect_to root_path unless current_user == @item.user

  @item.destroy
  redirect_to root_path, notice: '商品を削除しました。'
end

  private

  def set_item
    @item = Item.find(params[:id])
  end

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
  
   def redirect_if_not_seller
    redirect_to root_path unless current_user == @item.user
  end

  def redirect_if_sold_out
    redirect_to root_path if @item.order.present?
  end
end
