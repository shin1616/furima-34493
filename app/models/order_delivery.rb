class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :post_number, :prefecture_id, :municipality, :address, :apartment, :phone_number

  with_options presence: true do
    validates :post_number,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{,11}\z/}
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_number: post_number, prefecture_id: prefecture_id, municipality: municipality, address: address,
                    apartment: apartment, phone_number: phone_number, order_id: order.id)
  end
end
