require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def test_add_line_items_from_cart
    @order = Order.new(:name => 'demi', :address => 'somewhere', :email => 'demi@demi.com', :pay_type => 'cc')    
    cart = Cart.new
    cart.add_product(products(:one))
    assert @order.line_items.empty?
    @order.add_line_items_from_cart(cart)
    assert !@order.line_items.empty?
  end
end
