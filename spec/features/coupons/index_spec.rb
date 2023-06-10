require "rails_helper"

RSpec.describe "coupon#index" do
  before :each do

    @merchant1 = Merchant.create!(name: "Hair Care")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @coupon1 = Coupon.create!(name: "Summer Savings", code: "SUMMER25", amount_off: 25, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_1.id)
    @coupon2 = Coupon.create!(name: "First Time Buyer", code: "FIRST5", amount_off: 5, coupon_type: "amount_off", active: true, merchant_id: @merchant1.id, invoice_id: nil)
    @coupon3 = Coupon.create!(name: "New Years", code: "NY15", amount_off: 15, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_3.id)
    @coupon4 = Coupon.create!(name: "Hooray", code: "42987", amount_off: 8, coupon_type: "amount_off", active: false, merchant_id: @merchant1.id, invoice_id: nil)
    @coupon5 = Coupon.create!(name: "I Like Cookies", code: "Yum15", amount_off: 15, coupon_type: "amount_off", active: true, merchant_id: @merchant1.id, invoice_id: nil)
    @coupon6 = Coupon.create!(name: "Yowza", code: "OUCH12", amount_off: 12, coupon_type: "percent_off", active: false, merchant_id: @merchant1.id, invoice_id: nil)
    @coupon7 = Coupon.create!(name: "Kila Pants", code: "KP123", amount_off: 80, coupon_type: "percent_off", active: false, merchant_id: @merchant1.id, invoice_id: nil)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

  end

    it "displays a link to view all coupons" do
      visit merchant_dashboard_index_path(@merchant1)

      expect(page).to have_link("View All Coupons")

      click_link("View All Coupons")

      expect(current_path).to eq(merchant_coupons_path(@merchant1))
      expect(page).to have_content(@coupon1.name)
      expect(page).to have_content(@coupon1.amount_off)
      expect(page).to have_content(@coupon2.name)
      expect(page).to have_content(@coupon2.amount_off)
      expect(page).to have_content(@coupon3.name)
      expect(page).to have_content(@coupon3.amount_off)
      expect(page).to have_content(@coupon4.name)
      expect(page).to have_content(@coupon4.amount_off)
    end

    it "links each coupon to its show page" do
      visit merchant_coupons_path(@merchant1)

      expect(page).to have_link(@coupon1.name)
      expect(page).to have_link(@coupon2.name)
      expect(page).to have_link(@coupon3.name)
      expect(page).to have_link(@coupon4.name)
    end

    it "creates a new coupon" do
      visit merchant_coupons_path(@merchant1)

      expect(page).to have_link("Create a Coupon")

      click_link("Create a Coupon")

      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))

      fill_in "Name", with: "Back to School Savings"
      fill_in "Code", with: "BTS23"
      fill_in "coupon_amount_off", with: 10
      select "percent_off", from: "coupon_coupon_type"
      click_button "Create Coupon"

      expect(current_path).to eq(merchant_coupons_path(@merchant1))

      expect(page).to have_content("Back to School Savings")
      expect(page).to have_content(10)
    end

    it "has 5 active coupons" do
      @coupon5 = Coupon.create!(name: "Supercool", code: "coolio123", amount_off: 25, coupon_type: "percent_off", active: true, merchant_id: @merchant1.id, invoice_id: @invoice_1.id)

      visit merchant_coupons_path(@merchant1)

      click_link("Create a Coupon")

      fill_in "Name", with: "Cha cha cha"
      fill_in "Code", with: "12345"
      fill_in "coupon_amount_off", with: 10
      select "percent_off", from: "coupon_coupon_type"
      click_button "Create Coupon"


      expect(current_path).to eq(merchant_coupons_path(@merchant1))
      expect(page).to have_content("Error: You may only have 5 active coupons")
      expect(page).not_to have_content("Cha cha cha")
    end

    it "has invalid data" do
      visit merchant_coupons_path(@merchant1)

      click_link("Create a Coupon")

      fill_in "Name", with: "Cha cha cha"
      fill_in "Code", with: "SUMMER25"
      fill_in "coupon_amount_off", with: 10
      select "percent_off", from: "coupon_coupon_type"
      click_button "Create Coupon"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/coupons/new")
      expect(page).not_to have_link("Cha cha cha")
      expect(page).to have_content("Error: invalid data entered")
    end

    it "has active/inactive sections" do
      visit merchant_coupons_path(@merchant1)
      save_and_open_page
      within "#active" do
        expect(page).to have_content("#{@coupon1.name}")
        expect(page).to have_content("#{@coupon2.name}")
        expect(page).to have_content("#{@coupon3.name}")
        expect(page).to have_content("#{@coupon5.name}")
    end

      within "#inactive" do
        expect(page).to have_content("#{@coupon4.name}")
        expect(page).to have_content("#{@coupon6.name}")
        expect(page).to have_content("#{@coupon7.name}")
    end
  end
end