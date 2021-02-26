class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :period

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