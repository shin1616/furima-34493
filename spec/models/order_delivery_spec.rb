require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
      sleep(0.05)
    end
    context '商品を購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
      it 'apartmentは空白でも保存できること' do
        @order_delivery.apartment = ''
        expect(@order_delivery).to be_valid
      end
    end
    context '商品を購入できないとき' do
      it 'post_numberが空だと保存できないこと' do
        @order_delivery.post_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post number can't be blank")
      end
      it 'post_numberが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_delivery.post_number = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end
      it 'post_numberに全角数字が含まれると保存できないこと' do
        @order_delivery.post_number = '１２３-４５６７'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_delivery.prefecture_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefectureがid:1では登録できない' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'municipalityが空だと保存できないこと' do
        @order_delivery.municipality = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_delivery.address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角数字だと保存できないこと' do
        @order_delivery.phone_number = '０８０１２３４５６７８'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが11桁より大きいと（12桁だと）保存できないこと' do
        @order_delivery.phone_number = '080123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number is invalid")
      end
      it 'tokenが空だと保存できないこと' do
        @order_delivery.token = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐づかない場合は登録できない' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づかない場合は登録できない' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end