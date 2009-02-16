require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  def test_from_cart_item
    cart = Cart.new
    cart.add_product(products(:one))
    li = LineItem.from_cart_item(cart.items.first)
    assert cart.items.first.price == li.total_price
  end
end
