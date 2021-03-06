class ConfirmsController < ApplicationController
  require 'payjp'
  before_action :set_card, :set_item

  def index
    @user = current_user
    @address = DeliveryAddress.find_by(user_id: current_user.id)
    
    
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.payjp_id)
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id, #顧客ID
      currency: 'jpy', #日本円
    )
    @item.update(buyer_id: current_user.id)
    redirect_to done_item_confirms_path
  end

  def done
  end
  
  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end