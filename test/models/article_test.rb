require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(title: 'a'*5, description: 'a'*10, user_id: User.first.id)
  end
  test 'valid' do
    assert @article.valid?
  end

  test 'title and description should be present' do
    @article.title = ''
    assert_not @article.valid?
    @article.description = ''
    assert_not @article.valid?
  end

  test 'title should not be too short' do
    @article.title = 't'
    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = 't'*102
    assert_not @article.valid?
  end
  test 'description should not be too short' do
    @article.description = 't'
    assert_not @article.valid?
  end
end
