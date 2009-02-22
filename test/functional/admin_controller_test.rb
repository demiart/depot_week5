require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  
  test "index requires authentication" do 
    get :index
    assert_redirected_to :controller => "admin", :action => "login" 
  end

  test "logged in ok on index" do
    @request.session[:user_id] = users(:one).id
    get :index
    assert_response :success
  end

  test "notice to log in if not logged in"  do
    get :index
    assert_match /please log in/i, flash[:notice]
  end

  test "password failure" do
    name = users(:one).name
    post :login, :name => name, :password => 'junk'
    assert_template "login"
    assert_match /invalid/i, flash[:notice]
  end
end
