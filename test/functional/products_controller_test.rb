require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should show product" do
    get :show, :id => products(:one).id
    assert_response :success
    assert_tag :tag => 'b', :content => 'Title:'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_tag :tag => 'input', :attributes => {:name => 'product[title]', :id => 'product_title'}
    assert_tag :tag => 'textarea', :attributes => {:name => 'product[description]', :id => 'product_description'}
    assert_tag :tag => 'input', :attributes => {:name => 'product[image_url]', :id => 'product_image_url'}
    assert_tag :tag => 'input', :attributes => {:name => 'product[price]', :id => 'product_price'}
  end

  test "should get edit" do
    get :edit, :id => products(:one).id
    assert_response :success
    assert_tag :tag => 'input', :attributes => {:name => 'product[title]', :id => 'product_title'}
    assert_tag :tag => 'textarea', :attributes => {:name => 'product[description]', :id => 'product_description'}
    assert_tag :tag => 'input', :attributes => {:name => 'product[image_url]', :id => 'product_image_url'}
    assert_tag :tag => 'input', :attributes => {:name => 'product[price]', :id => 'product_price'}
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => { 
        :title => 'test monkey',
        :description => 'new monkey test',
        :image_url => 'http://www.monkey.com/noimg.jpg',
        :price => '1999'
      }
    end
    assert_match /created/i, flash[:notice]
    assert_redirected_to product_path(assigns(:product))
  end

  test "should update product" do
    put :update, :id => products(:one).id, :product => { 
      :title => 'super awesome monkey',
      :description => products(:one).description,
      :image_url => products(:one).image_url,
      :price => products(:one).price
    }
    assert_match /updated/i, flash[:notice]
    assert_redirected_to product_path(assigns(:product))
    assert_equal 'super awesome monkey', Product.find(products(:one).id).title
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => products(:one).id
    end

    assert_redirected_to products_path
  end
end
