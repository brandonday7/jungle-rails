require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"


  describe 'Validations' do

    context 'given a fully filled product form' do
      it 'returns true' do
        @category = Category.find_or_create_by! name: 'Electronics'
        @product = Product.new(name: 'Toaster', price: 24.99, quantity: 5, category: @category)
        expect(@product.save()).to be true
      end
    end

    context 'given an empty name field' do
      it "returns error message 'name not valid'" do
        @category = Category.find_or_create_by! name: 'Electronics'
        @product = Product.new(name: nil, price: 24.99, quantity: 5, category: @category)
        @product.save()
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'given an empty price field' do
      it "returns error message 'price not valid'" do
        @category = Category.find_or_create_by! name: 'Electronics'
        @product = Product.new(name: 'Toaster', price: nil, quantity: 5, category: @category)
        @product.save()
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context 'given an empty quantity field' do
      it "returns error message 'quantity not valid'" do
        @category = Category.find_or_create_by! name: 'Electronics'
        @product = Product.new(name: 'Toaster', price: 24.99, quantity: nil, category: @category)
        @product.save()
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context 'given an empty category field' do
      it "returns error message 'category not valid'" do
        @product = Product.new(name: 'Toaster', price: 24.99, quantity: 5, category: nil)
        @product.save()
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end



  end
end
