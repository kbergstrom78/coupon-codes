

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

@coupon1 = Coupon.create!(name: "goodest boy", coupon_type: "percent_off", discount: 20, code: "GB123", merchant_id: 25)
@coupon2 = Coupon.create!(name: "boop the snoot", coupon_type: "percent_off", discount: 30, code: "BTS123", merchant_id: 25)
@coupon3 = Coupon.create!(name: "big ol' pupper", coupon_type: "amount_off", discount: 10, code: "BOOP246", merchant_id: 25)
@coupon4 = Coupon.create!(name: "long boi", coupon_type: "amount_off", discount: 30, code: "LBOI2023", merchant_id: 80)
@coupon5 = Coupon.create!(name: "thicc doggo", coupon_type: "percent_off", discount: 0, code: "THICC123", merchant_id: 80)
@coupon6 = Coupon.create!(name: "smoll pupperino", coupon_type: "amount_off", discount: 5, code: "SMOLL56", merchant_id: 60)
@coupon8 = Coupon.create!(name: "big borker", coupon_type: "percent_off", discount: 98, code: "BIGBORK34", merchant_id: 35)
@coupon9 = Coupon.create!(name: "small floof", coupon_type: "amount_off", discount: 10, code: "FLOOF89", merchant_id: 5)
@coupon10 = Coupon.create!(name: "busy splooting", coupon_type: "percent_off", discount: 40, code: "SPLOOT78", merchant_id: 32)
@coupon11 = Coupon.create!(name: "yes this is dog ", coupon_type: "amount_off", discount: 5, code: "YESDOG98", merchant_id: 60)
@coupon12 = Coupon.create!(name: "you did me a bamboozle", coupon_type: "percent_off", discount: 15, code: "BAMBOOZLE3", merchant_id: 115)