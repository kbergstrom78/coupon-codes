class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum coupon_type: {
    percent_off: 0,
    amount_off: 1
  }

  validates :name, :code, :coupon_type, :merchant_id, :amount_off, presence: true
  validates :code, uniqueness: true
  validates :amount_off, numericality: { only_integer: true }

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