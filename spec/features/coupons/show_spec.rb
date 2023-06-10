require "rails_helper"

RSpec.describe "merchant dashboard" do
  describe "coupon#show" do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Charlie's Chia Pets")
      @merchant2 = Merchant.create!(name: "Bianca's Baubles")

      @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
      @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
      @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
      @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
      @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon: @coupon1)
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon: @coupon1)
      @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon: @coupon2)
      @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2, coupon: @coupon1)
      @invoice_5 = Invoice.create!(customer_id: @customer_2.id, status: 2)


      @coupon1 = Coupon.create!(name: "Summer Savings", code: "ABOI34", amount_off: 25, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_1.id)
      @coupon2 = Coupon.create!(name: "First Time Buyer", code: "JKHFD23", amount_off: 5, coupon_type: "amount_off", active: true, merchant_id: @merchant1.id, invoice_id: nil)
      @coupon3 = Coupon.create!(name: "New Years", code: "LKSFD89", amount_off: 15, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_3.id)
      @coupon4 = Coupon.create!(name: "Bday Freebie", code: "UYT35", amount_off: 10, coupon_type: "amount_off", active: true, merchant_id: @merchant1.id, invoice_id: nil)


      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
      @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
      @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)

      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
      @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
      @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
      @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
      @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
      @transaction8 = Transaction.create!(credit_card_number: 203942, result: 0, invoice_id: @invoice_1.id)
    end


    it "shows a coupon and its attributes" do
      visit merchant_coupon_path(@merchant1, @coupon1.id)

      expect(page).to have_content(@coupon1.name)
      expect(page).to have_content(@coupon1.code)
      expect(page).to have_content(@coupon1.amount_off)
      expect(page).to have_content(@coupon1.coupon_type)
      expect(page).to have_content(@coupon1.status)

      expect(page).to have_content("Usage Count: #{@coupon1.usage_count}")
    end

    it "deactivates a coupon" do
      visit merchant_coupon_path(@merchant1, @coupon1.id)
      expect(page).to have_content("Status: Active")
      expect(page).to have_button("Deactivate")
      click_button "Deactivate"
      save_and_open_page
      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1.id))
      expect(page).to have_content("Status: Inactive")
    end
  end
end



