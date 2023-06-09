class CouponsController < ActionController::Base
  def index
    @coupons = Coupon.all
  end
end