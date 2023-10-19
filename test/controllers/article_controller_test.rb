require "test_helper"

class ArticleControllerTest < ActionDispatch::IntegrationTest
  def setup
    @test_user = User.create(username: "test_user", email: "test_user@example.com",
                               password: "password", admin: false)
    @test_user_1 = User.create(username: "test_user_1", email: "test_user_1@example.com",
                               password: "password", admin: false)
    @admin_user = User.create(username: "admin", email: "admin@example.com",
                              password: "password", admin: true)
    @article = Article.create(title: 'a'*5, description: 'a'*10, user_id: @test_user.id)
  end

  test "should get show" do
    get article_path @article
    assert_response :success
  end

  test "should get new for logged in user" do
    sign_in_as(@test_user)
    get new_article_url
    assert_response 200
  end

  test "shouldn't get new without login" do
    get new_article_url
    assert_response :forbidden
  end

  test "should get for same user" do
    sign_in_as @test_user
    get edit_article_url @article
    assert_response :success

    sign_in_as @test_user_1
    get edit_article_url @article
    assert_response :forbidden
  end
end
