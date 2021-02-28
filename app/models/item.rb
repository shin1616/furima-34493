class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :period
  has_one_attached :image
  belongs_to :user

  VALID_PRICE = /\A[0-9]+\z/
  with_options presence: true do
    validates :name
    validates :price, format: { with: VALID_PRICE }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
    validates :text
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :prefecture_id
    validates :period_id
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :prefecture_id
    validates :period_id
  end
end