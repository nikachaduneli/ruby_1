require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'test123')
  end

  test 'valid' do
    assert @category.valid?
  end

  test 'name should be unique' do
    @category.save
    @category_2 = Category.new(name: 'test')
    assert_not @category_2.valid?
  end

  test 'name should be present' do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 't'
    assert_not @category.valid?
  end

  test 'name should not be too long' do
    @category.name = 't'*41
    assert_not @category.valid?
    @category.name = 't'*50
    assert_not @category.valid?
  end
end