require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "session has a cart" do
    get :index
    assert session[:cart]
  end

  test "adding to cart works" do
   get :index
   assert cart = session[:cart]
   assert_equal 0, cart.items.length   
   xhr :post, :add_to_cart, {:id => products(:one).id}
   assert_response :success
   assert_equal 1, cart.items.length
  end

  test "clearing cart works" do
    get :index
    assert cart = session[:cart]
    xhr :post, :add_to_cart, {:id => products(:one).id}
    assert_equal 1, cart.items.length
    post :empty_cart
    assert_redirected_to :controller => 'store', :action => :index
    get :index
    assert_tag :tag => 'div', :attributes => {:id => 'cart', :style => 'display: none'} 
  end

  test "redirect on bad index" do
    post :add_to_cart, :id => 8675309
    assert_redirected_to :action => 'index'
    assert flash[:notice]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    #check response for product data
    Product.find_products_for_sale.each {|p|
      assert_tag :tag =>'h3', :content => p.title
      assert_tag :tag =>'img', :attributes => {:src => '/images/' + p.image_url}
      assert_match /#{"%.2f" %  (p.price / 100.0)}/, @response.body  
    }
  end
end
