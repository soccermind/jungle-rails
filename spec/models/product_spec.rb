require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "should save a new product with all required fields set" do
      @category = Category.find_or_create_by! name: 'Hats'
      expect{@product = @category.products.create!({
        name:  'Cool Hat',
        quantity: 10,
        price: 64.99
      })}.to change {Product.count}
    end

    it "should not save a new product if name is missing" do
      @category = Category.find_or_create_by! name: 'Hats'
      expect{@product = @category.products.create!({
        name:  nil,
        quantity: 10,
        price: 64.99
      })}.to raise_error(/Name can't be blank/)
    end

    it "should not save a new product if quantity is missing" do
      @category = Category.find_or_create_by! name: 'Hats'
      expect{@product = @category.products.create!({
        name:  'Cool Hat',
        quantity: nil,
        price: 64.99
      })}.to raise_error(/Quantity can't be blank/)
    end

    it "should not save a new product if price is missing" do
      @category = Category.find_or_create_by! name: 'Hats'
      expect{@product = @category.products.create!({
        name:  'Cool Hat',
        quantity: 10,
        price: nil
      })}.to raise_error(/Price can't be blank/)
    end

    it "should not save a new product if category is missing" do
      @category = nil
      expect{@product = products.create!({
        name:  'Cool Hat',
        quantity: 10,
        price: 64.99
      })}.to raise_error(/undefined local variable or method `products'/)
    end

  end
end
