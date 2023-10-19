require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "test_user", email: "test_user@example.com",
                        password: "password", admin: false)
    @admin = User.create(username: "admin", email: "admin@example.com",
                        password: "password", admin: true)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { username: "test_user_1", email: "test_user_1@example.com",
                                        password: "password", admin: false  } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as @user
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    sign_in_as @user
    patch user_url(@user), params: { user: { username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    sign_in_as @user
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
  end
end
