class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum coupon_type: {
    percent_off: 0,
    amount_off: 1
  }


  def status
    if self.active
      "Active"
    else
      "Inactive"
    end
  end

  def usage_count
    invoices.joins(:transactions)
    .where(transactions: { result: 'success' })
    .count
  end
end