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

  before_update :check_for_pending_invoices, if: -> { active_changed?(from: true, to: false) }
  
  def status
    if self.active
      "Active"
    else
      "Inactive"
    end
  end

  def check_for_pending_invoices
    if invoices.where(status: 1).any?
      errors.add(:active, "cannot be deactived; used in pending invoice")
      throw :abort
    end
  end

  def usage_count
    invoices.joins(:transactions)
    .where(transactions: { result: 'success' })
    .count
  end
end