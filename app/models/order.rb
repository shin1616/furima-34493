class Order < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :token
  validates :price, presence: true
  validates :token, presence: true

  belongs_to :user
  has_one :deliveries
end
