class CouponsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    @coupons = @merchant.coupons
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.create!(coupon_params)
      if @coupon.save
        redirect_to merchant_coupons_path(@merchant), notice: "Success!  A new coupon has been created!"
      else
        render :new
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