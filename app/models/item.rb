class Item < ApplicationRecord
  belongs_to :user

  # ActiveStorageで画像を持たせる
  has_one_attached :image

  # ActiveHash用の関連付け（5つ）
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  # バリデーション設定
  with_options presence: true do
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
