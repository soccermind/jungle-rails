require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
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


  scenario "When clicking on a product link they navigate to the product details page" do
    # ACT
    visit root_path
    first('article.product header a').click
    sleep(1)
    
    # DEBUG / VERIFY
    save_screenshot("product_details.png")

    expect(page).to have_css 'article.product-detail', count: 1

  end
end
