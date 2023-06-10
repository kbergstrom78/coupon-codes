class Coupon < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice, optional: true

  enum coupon_type: {
    percent_off: 0,
    amount_off: 1
  }

end