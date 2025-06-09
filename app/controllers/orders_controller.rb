class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    else
      @order_address = OrderAddress.new
    end
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      if pay_item
        @order_address.save
        redirect_to root_path and return
      else
        # pay_item で例外が起きたらここに来る
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

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: @item.id,
      token: params[:token]
    )
  end

  # true を返すと正常、false を返すと決済失敗として index に戻す
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # create! ではなく create を使います
    Payjp::Charge.create(
      amount:    @item.price,
      card:      order_address_params[:token],
      currency:  'jpy'
    )
    true
  rescue Payjp::PayjpError => e
    # Payjp::Error ではなく Payjp::PayjpError を rescue します
    flash.now[:alert] = "カード決済に失敗しました (#{e.message})"
    false
  end
end