require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  def setup
    @myitem = CartItem.new products(:one)
  end

  test "test init" do
    assert_equal products(:one).id, @myitem.product.id
    assert_equal 1, @myitem.quantity
  end

  test "test increment quantity" do
    @myitem.increment_quantity 
    assert_equal 2, @myitem.quantity
  end

  test "test title" do
    assert_equal 'Monkey1', @myitem.title
  end 
  
  test "test price" do
    assert_equal 1395, @myitem.price
  end
end