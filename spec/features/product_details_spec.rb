require 'rails_helper'

RSpec.feature "Visitor navigates to a product from the home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click 'Details' to see the product's page" do
    # ACT
    visit root_path
    click_on 'Details'


    # VERIFY
    expect(page).to have_content "Reviews:"

    # DEBUG
    save_screenshot
  end
end