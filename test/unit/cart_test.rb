require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @mycart = Cart.new
  end

  test "test init" do
    assert_equal 0, @mycart.items.length
  end

  test "test add product" do
    @mycart.add_product products(:one)
    assert_equal 1, @mycart.items.length
    @mycart.add_product products(:two)
    assert_equal 2, @mycart.items.length
    # array has line items, not individual products 
    @mycart.add_product products(:one)
    assert_equal 2, @mycart.items.length
  end

  test "test total price" do
    assert_equal 0, @mycart.total_price
    @mycart.add_product products(:one)
    @mycart.add_product products(:one)
    assert_equal 2 * products(:one).price, @mycart.total_price
  end
  
  test "test total items" do
    assert_equal 0, @mycart.total_items
    @mycart.add_product products(:one)
    @mycart.add_product products(:one)
    assert_equal 2, @mycart.total_items
  end
end