class Item < ApplicationRecord
  has_one_attached :image

  with_options presence: true do
    validates :name          
    validates :price         
    validates :text          
    validates :category_id   
    validates :status_id     
    validates :postage_id    
    validates :prefecture_id 
    validates :period_id     
  end
end