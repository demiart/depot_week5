require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    #check response for product data
    Product.find_products_for_sale.each {|p|
      assert_tag :tag =>'h3', :content => p.title
      assert_tag :tag =>'img', :attributes => {:src => '/images/' + p.image_url}
      # QUESTION: is sprintf or format better?
      assert_match /#{format("%.2f", p.price / 100.0)}/, @response.body  
    }
  end
end
