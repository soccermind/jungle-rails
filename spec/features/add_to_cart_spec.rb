require 'rails_helper'

RSpec.feature "Visitor adds product to shopping cart", type: :feature, js: true  do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario "In the home page, when clicking on an 'Add to Cart' button, the quantity on the 'My Cart' element is updated" do
    # ACT
    visit root_path
    my_cart_text_before = find("a[href='#{cart_path}']").text
    # save_screenshot("add_to_cart_zero.png")
    first(:button, 'Add').click

    sleep(1)
    
    # DEBUG / VERIFY
    # save_screenshot("add_to_cart_one.png")
    
    my_cart_text_after = find("a[href='#{cart_path}']").text
    expect(my_cart_text_before).to eq("My Cart (0)")
    expect(my_cart_text_after).to eq("My Cart (1)")
  end
end
