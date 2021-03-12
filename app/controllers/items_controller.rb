class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item,             only: [:show, :edit, :update, :destroy]
  before_action :move_to_index,        only: [:edit, :update, :destroy]
  before_action :done_order,           only: [:edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :text, :category_id, :status_id, :postage_id, :prefecture_id,
                                 :period_id, images: []).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @item.user_id
  end

  def done_order
    redirect_to root_path if @item.order.present?
  end
end
