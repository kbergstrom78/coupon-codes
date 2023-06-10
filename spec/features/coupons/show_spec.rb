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

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
      @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)

      @coupon1 = Coupon.create!(name: "Summer Savings", code: "ABOI34", amount_off: 25, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_1.id)
      @coupon2 = Coupon.create!(name: "First Time Buyer", code: "JKHFD23", amount_off: 5, coupon_type: "amount_off", active: true, merchant_id: @merchant1.id, invoice_id: nil)
      @coupon3 = Coupon.create!(name: "New Years", code: "LKSFD89", amount_off: 15, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_3.id)
      @coupon4 = Coupon.create!(name: "Bday Freebie", code: "UYT35", amount_off: 10, coupon_type: "amount_off", active: true, merchant_id: @merchant1.id, invoice_id: nil)
    end

    it "shows a coupon and its attributes" do
      visit merchant_coupon_path(@merchant1, @coupon1.id)
      save_and_open_page
      expect(page).to have_content(@coupon1.name)
      expect(page).to have_content(@coupon1.code)
      expect(page).to have_content(@coupon1.amount_off)
      expect(page).to have_content(@coupon1.coupon_type)
      expect(page).to have_content(@coupon1.status)

      expect(page).to have_content("Usage Count: #{@coupon1.usage_count}")
    end
  end
end



