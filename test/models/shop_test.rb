require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  setup do
    @shop = shops(:virtualo)
  end

  test 'Valid with name' do
    assert @shop.valid?
  end

  test 'Invalid with no name' do
    @shop.name = ''
    assert @shop.invalid?
    assert_equal ["can't be blank"], @shop.errors.messages[:name]
  end

  test 'Slug method' do
    @shop.name = 'Some very long łikend'
    assert_equal 'some-very-long-likend', @shop.slug
  end

  test 'to_param method is now equal to slug' do
    @shop.name = 'Some very long łikend'
    assert_equal @shop.slug, @shop.to_param
  end
end
