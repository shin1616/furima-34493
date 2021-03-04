class Orders < ApplicationRecord
  validates :price, presence: true
end
