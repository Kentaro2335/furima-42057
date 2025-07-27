class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_select_data, only: [:new, :edit, :update]
  before_action :set_item, only: [:edit, :update]

  def edit
    redirect_to root_path unless current_user == @item.user
  end

  def update
    if current_user == @item.user
      if @item.update(item_params)
        redirect_to item_path(@item), notice: '商品を更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path
    end
  end

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_select_data
    @categories = Category.all
    @conditions = Condition.all
    @shipping_fee_statuses = ShippingFeeStatus.all
    @prefectures = Prefecture.all
    @scheduled_deliveries = ScheduledDelivery.all
  end

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end
end

# 商品情報編集機能の微修正
