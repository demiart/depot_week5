require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  def test_good_login
    post :login, :name => 'testname', :password => 'mypass'
#    assert_redirected_to 'index'  
#    assert_not_nil session[:user_id]
  end
end
