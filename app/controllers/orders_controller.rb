class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
   before_action :redirect_if_invalid_purchase, only: [:index, :create]

  def index
     @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      if pay_item
        @order_address.save
        redirect_to root_path and return
      else
        render :index and return
      end
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

 def redirect_if_invalid_purchase
  if current_user == @item.user || @item.order.present?
    redirect_to root_path
  end
end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: @item.id,
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']

    Payjp::Charge.create(
      amount:    @item.price,
      card:      order_address_params[:token],
      currency:  'jpy'
    )
    true
  rescue Payjp::PayjpError => e

    flash.now[:alert] = "カード決済に失敗しました (#{e.message})"
    false
  end
end