class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number,
                :item_id, :user_id, :token

  validates :postal_code,
            presence: true,
            format: { with: /\A\d{3}-\d{4}\z/, message: 'は「123-4567」の形式で入力してください' }

  validates :prefecture_id,
            presence: true,
            numericality: { other_than: 0, message: 'を選択してください' }

  validates :city, presence: true
  validates :address, presence: true

  validates :phone_number,
            presence: true,
            format: { with: /\A\d{10,11}\z/, message: 'は10〜11桁の半角数字で入力してください' }

  validates :token, :item_id, :user_id, presence: true


  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end