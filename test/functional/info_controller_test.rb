require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  def setup
    li = LineItem.new(:product_id => products(:one).id, :order_id => orders(:one).id, :quantity => 1, :total_price => 1000)
    li.save!
  end  

  test "can get json info on order" do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    get :who_bought, :id => products(:one).id
    assert_match /\"product\":/, @response.body
  end

  test "can get atom info on order" do
    @request.env['HTTP_ACCEPT'] = 'application/atom+xml'
    get :who_bought, :id => products(:one).id
    assert_tag :tag => 'link', :attributes => { :type => 'application/atom+xml' }
  end

  test "can get xml info on order" do
    @request.env['HTTP_ACCEPT'] = 'application/xml'
    get :who_bought, :id => products(:one).id
    assert_tag :tag => 'name', :content => 'productbuyer'
  end

  test "can get html info on order" do
    get :who_bought, :id => products(:one).id
    assert_match /!DOCTYPE/, @response.body
    assert_match /productbuyer/, @response.body  
  end
end
