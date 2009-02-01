require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product has price" do
    product = products(:one)
    product.price = 1000
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

  test "product validates presence of url" do
    product = Product.new
    assert !product.valid?
    assert product.errors.on(:image_url)
  end
  
  test "that price must be a number" do
    product = products(:one)
    product.price = 'bad value'
    assert !product.valid?
    assert product.errors.on(:price)
    product.price = 100
    assert product.valid?
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
    product = products(:one)
    product.price = 1
    assert product.save!
  end

  test "that titles are unique" do
    product = Product.new(products(:one).attributes)
    assert !product.valid?
    assert product.errors.on(:title)
  end

  test "urls must be formatted properly" do
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
    assert_equal Product.find(:all).sort_by {|p|
      p.title
    }, products_for_sale
  end
end
