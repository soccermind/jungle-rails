require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "should save a new product with all required fields set" do
      @category = Category.new name: 'Hats'
      @product = @category.products.new({
        name:  'Cool Hat',
        quantity: 10,
        price: 64.99
      })
      expect{@product.save!}.to change {Product.count}
    end

    it "should not save a new product if name is missing" do
      @category = Category.new name: 'Hats'
      @product = @category.products.new({
        name:  nil,
        quantity: 10,
        price: 64.99
      })
      @product.validate
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save a new product if quantity is missing" do
      @category = Category.new name: 'Hats'
      @product = @category.products.new({
        name:  'Cool Hat',
        quantity: nil,
        price: 64.99
      })
      @product.validate
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save a new product if price is missing" do
      @category = Category.new name: 'Hats'
      @product = @category.products.new({
        name:  'Cool Hat',
        quantity: 10,
        price: nil
      })
      @product.validate
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not save a new product if category is missing" do
      @product = Product.new({
        name:  'Cool Hat',
        quantity: 10,
        price: 64.99
      })
      @product.validate
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
