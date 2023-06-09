class AddAmountOffToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :amount_off, :integer
  end
end
