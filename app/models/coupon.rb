class Coupon < ApplicationRecord
  validates_presence_of :name,
  :code,
  :amount_off,
  :coupon_type,
  :active
  :merchant_id



  belongs_to :merchant
  belongs_to :invoice, optional: true

  enum coupon_type: {
    percent_off: 0,
    amount_off: 1
  }

  validate :active_coupon_limit, on: :create

  def active_coupon_limit
    return unless merchant

    if merchant.coupons.where(active: true).size >= 5
      errors.add(:base, "Merchant cannot have more than 5 active coupons")
    end
  end
end