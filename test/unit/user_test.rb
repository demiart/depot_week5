require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_encrypted_password
    result = User.encrypted_password("testpass", "testsalt")
    assert_equal 40, result.length
  end

  def test_new_salt
    user = User.new
    mysalt = user.create_new_salt
    assert mysalt
  end

  def test_password_assign_goodval
    user = User.new
    user.password = 'mypass'
    assert user.hashed_password
  end

  def test_password_assign_noval
    user = User.new
    user.password = ''
    assert !user.hashed_password
  end

  def test_authenticate
    assert User.authenticate('testuser', 'mypass')
  end

  def test_failed_authenticate
    assert !User.authenticate('junk', 'junk')
  end
end
