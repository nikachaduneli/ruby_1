require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'test123', email: 'test@gmail.com', password_digest: 'Testing123')
  end

  test 'valid' do
    assert @user.valid?, @user.errors.full_messages
  end

  test 'username should be unique' do
    @user.save
    @user_2 = User.new(username: 'test123', email: 'tes1t@gmail.com', password_digest: 'Testing123')
    assert_not @user_2.valid?
  end
  test 'email should be unique' do
    @user.save
    @user_2 = User.new(username: 'test125', email: 'test@gmail.com', password_digest: 'Testing123')
    assert_not @user_2.valid?
  end

  test 'username should be present' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'username should not be too short' do
    @user.username = 't'
    assert_not @user.valid?
  end

  test 'username should not be too long' do
    @user.username = 't'*41
    assert_not @user.valid?
    @user.username = 't'*50
    assert_not @user.valid?
  end
end
