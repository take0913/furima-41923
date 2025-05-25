class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_day
  has_one_attached :image

  has_one :purchase

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true

  validates :category_id,      presence: true, numericality: { other_than: 0, message: "must be other than 0" }
  validates :status_id,        presence: true, numericality: { other_than: 0, message: "must be other than 0" }
  validates :shipping_fee_id,  presence: true, numericality: { other_than: 0, message: "must be other than 0" }
  validates :prefecture_id,    presence: true, numericality: { other_than: 0, message: "must be other than 0" }
  validates :delivery_day_id,  presence: true, numericality: { other_than: 0, message: "must be other than 0" }

  validates :price, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999,
                    }
end