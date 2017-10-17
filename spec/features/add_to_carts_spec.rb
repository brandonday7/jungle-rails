require 'rails_helper'

RSpec.feature "Visitor's cart gets updated when they add product to cart", type: :feature, js: true do

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

  scenario "They click 'Add to cart' to change cart contents" do
    # ACT
    #user must be logged in to contribute to cart

  @user1 = User.create!(first_name: 'Harry Potter', last_name: 'Potter', email: 'harry_p@magic.com', password: 'abcd')

    visit '/login'
    fill_in "email", with: 'harry_p@magic.com'
    fill_in "password", with: 'abcd'
    click_on 'Submit'

    #add to cart
    first('.product').click_on('Add')




    # VERIFY
    expect(page).to have_content "My Cart (1)"

    # DEBUG
    puts page.html

    save_screenshot

  end
end