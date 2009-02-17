require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "can get xml info on order" do
    li = LineItem.new(:product_id => products(:one).id, :order_id => orders(:one).id, :quantity => 1, :total_price => 1000)
    li.save!
    get :who_bought, :id => products(:one).id
    assert_tag :tag => 'name', :content => 'productbuyer'
  end
end
