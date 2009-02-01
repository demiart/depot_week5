require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product has price attr" do
    product = products(:one)
    product.price = 10
    product.save!
  end

  test "product validates presence of title" do
    product = Product.new
    assert !product.valid?
    assert product.errors.on(:title)
  end

  test "product validates presence of description" do
    product = Product.new
    assert !product.valid?
    assert product.errors.on(:description)
  end

  test "product validates presence of image url" do
    product = Product.new
    assert !product.valid?
    assert product.errors.on(:image_url)
  end
  
  test "product validates numericality of price" do
    product = Product.new
    product.price = 'bad val'
    assert !product.valid?
    assert product.errors.on(:price)
    product.price = 100
    assert !product.valid?
    assert !product.errors.on(:price)
  end

  test "product validates price must be at least a cent" do
    product = Product.new
    product.price = 0.1 #one-tenth of a cent in model
    assert !product.valid?
    assert product.errors.on(:price)
    product.price = -1
    assert !product.valid?
    assert product.errors.on(:price)
    product.price = 0
    assert !product.valid?
    assert product.errors.on(:price)
    product.price = 1
    assert !product.valid?
    assert !product.errors.on(:price)
  end

  test "product validates uniqueness of title" do
    product = Product.new
    product.title = products(:one).title
    assert !product.valid?
    assert product.errors.on(:title)
    product.title = 'this is a unique title'
    assert !product.valid?
    assert !product.errors.on(:title)
  end

  test "product validates format of image url" do
    product = Product.new
    product.image_url = 'test.jpg'
    assert !product.valid?
    assert !product.errors.on(:image_url)
    product.image_url = 'test.gif'
    assert !product.valid?
    assert !product.errors.on(:image_url)
    product.image_url = 'test.png'
    assert !product.valid?
    assert !product.errors.on(:image_url)
    product.image_url = 'test.junk'
    assert !product.valid?
    assert product.errors.on(:image_url)
  end

  test "find products for sale" do
    products_for_sale = Product.find_products_for_sale
    assert products_for_sale
  end
end
