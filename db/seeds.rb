

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Transaction.destroy_all
InvoiceItem.destroy_all
Item.destroy_all
Invoice.destroy_all
Merchant.destroy_all
Customer.destroy_all
Coupon.destroy_all

Rake::Task["csv_load:all"].invoke

  20.times do |i|
    Coupon.create!(
      name: "Coupon ##{i+1}",
      code: SecureRandom.alphanumeric(6).upcase,
      amount_off: rand(5..50),
      coupon_type: ["percent_off", "amount_off"].sample,
      active: [true, false].sample,
      merchant_id: Merchant.all.sample.id,
      invoice_id: Invoice.all.sample.id
    )
  end
end