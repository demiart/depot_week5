require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "session has a cart" do
    get :index
    assert session[:cart]
  end

  test "checkout redirects on empty with message" do
    get :index
    assert cart = session[:cart]
    post 'checkout'
    assert_redirected_to :action => 'index'
    get :index
    assert_match /your cart is empty/i, @response.body
  end

  test "checkout not redirected on full cart" do
    get :index
    assert cart = session[:cart]
    cart.add_product(products(:one))
    post 'checkout'
    assert_match /please enter your details/i, @response.body
  end

  test "save order works with good order data" do
    get :index
    assert cart = session[:cart]
    cart.add_product(products(:one))
    post 'save_order', :order => {
      :name => 'demi',
      :address => 'somewhere', 
      :email => 'demi@demi.com',
      :pay_type => 'cc'
    }
    assert_redirected_to :action => :index
    get :index
    assert_match /thanks for your order/i, @response.body    
  end

  test "save order fails with bad order data" do
    get :index
    assert cart = session[:cart]
    cart.add_product(products(:one))
    post 'save_order', :order => {
      :name => 'demi',
      :address => 'somewhere', 
      :email => 'demi@demi.com',
      :pay_type => 'junkvalue'
    }
    assert_match /there were problems/i, @response.body 
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

  test "spanish localization, title" do
    get :index, :locale => 'es'
    assert_tag :tag => "div", :attributes => {:id => "banner"}, :content => /marqueta/
  end

  test "spanish localiation, cart title" do
    get :index, :locale => 'es'
    assert_tag :tag => "div", :attributes => {:class => "cart-title"}, :content => /Carrito/
  end

  test "spanish localization, side" do
    get :index, :locale => 'es'
    assert_tag :tag => "a", :content => /inicio/i
    assert_tag :tag => "a", :content => /preguntas/i
    assert_tag :tag => "a", :content => /noticias/i
    assert_tag :tag => "a", :content => /contacto/i
  end

  test "spanish localization, cart" do
    get :index, :locale => 'es'
    cart = session[:cart]
    xhr :post, :add_to_cart, {:id => products(:three).id}
    assert_equal 1, cart.items.length
    assert_match /total-cell[^"]*\"[^>]*>\d+,\d\d[^\$]*\$US/, @response.body
    assert_match /input[^>]*Vaciar Carrito/i, @response.body
    assert_match /input[^>]*Comprar/i, @response.body
  end

  test "spanish localization, checkout and errors" do
    get :index, :locale => 'es'
    cart = session[:cart]
    xhr :post, :add_to_cart, {:id => products(:three).id}
    post "checkout"
    assert_response :success
    assert_match /introduzca\ssus\sdatos/i, @response.body
    assert_tag :tag => "label", :content => "Nombre"
    assert_tag :tag => "label", :content => "Direcci&oacute;n"
    assert_tag :tag => "label", :content => "Email"
    assert_tag :tag => "label", :content => "Pagar con"
    assert_tag :tag => "option", :content => /Seleccione/
    post "save_order"
    #no data - should have 5 errors
    assert_match /5\serrores/, @response.body
  end
end
