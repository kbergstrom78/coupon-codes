

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

InvoiceItem.destroy_all
Item.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Coupon.destroy_all
Customer.destroy_all
Merchant.destroy_all

Rake::Task["csv_load:all"].invoke

@merchant1 = Merchant.create!(name: "Charlie's Chia Pets")
@merchant2 = Merchant.create!(name: "Bianca's Baubles")

@customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
@customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
@customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
@customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
@customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
@customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

@coupon1 = Coupon.create!(name: "goodest boy", coupon_type: "percent_off", amount_off: 20, code: "GB123", merchant_id: 1)
@coupon2 = Coupon.create!(name: "boop the snoot", coupon_type: "percent_off", amount_off: 30, code: "BTS123", merchant_id: 1)
@coupon3 = Coupon.create!(name: "big ol' pupper", coupon_type: "amount_off", amount_off: 10, code: "BOOP246", merchant_id: 1)
@coupon4 = Coupon.create!(name: "long boi", coupon_type: "amount_off", amount_off: 30, code: "LBOI2023", merchant_id: 2)
@coupon5 = Coupon.create!(name: "thicc doggo", coupon_type: "percent_off", amount_off: 0, code: "THICC123", merchant_id: 2)
@coupon6 = Coupon.create!(name: "smoll pupperino", coupon_type: "amount_off", amount_off: 5, code: "SMOLL56", merchant_id: 1)
@coupon8 = Coupon.create!(name: "big borker", coupon_type: "percent_off", amount_off: 98, code: "BIGBORK34", merchant_id: 2)
@coupon9 = Coupon.create!(name: "small floof", coupon_type: "amount_off", amount_off: 10, code: "FLOOF89", merchant_id: 1)
@coupon10 = Coupon.create!(name: "busy splooting", coupon_type: "percent_off", amount_off: 40, code: "SPLOOT78", merchant_id: 1)
@coupon11 = Coupon.create!(name: "yes this is dog ", coupon_type: "amount_off", amount_off: 5, code: "YESDOG98", merchant_id: 2)
@coupon12 = Coupon.create!(name: "you did me a bamboozle", coupon_type: "percent_off", amount_off: 15, code: "BAMBOOZLE3", merchant_id: 1)

@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon: @coupon1)
@invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon: @coupon1)
@invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon: @coupon2)
@invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2, coupon: @coupon1)
@invoice_5 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon: @coupon10)
@invoice_5 = Invoice.create!(customer_id: @customer_2.id, status: 2)

@transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
@transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
@transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
@transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
@transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
@transaction8 = Transaction.create!(credit_card_number: 203942, result: 0, invoice_id: @invoice_1.id)