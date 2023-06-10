class CouponsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    @coupons = @merchant.coupons
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)

    if @merchant.active_coupons >= 5
      flash[:alert] = "Error: You may only have 5 active coupons"
      redirect_to merchant_coupons_path(@merchant)
    elsif @merchant.coupon_valid?(@coupon.code) && @coupon.save
      flash[:notice] = "Success! A new coupon has been created!"
      redirect_to merchant_coupons_path(@merchant)
    else
      flash[:alert] = "Error: invalid data entered"
      redirect_to new_merchant_coupon_path(@merchant)
    end
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount_off, :coupon_type)
  end

end