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

  test 'Has slug assigned upon validation' do
    new_shop = Shop.new(name: 'Some very long łikend')
    new_shop.validate
    assert_equal 'some-very-long-likend', new_shop.to_slug
  end

  test 'to_param method is now equal to to_slug' do
    @shop.name = 'Some very long łikend'
    assert_equal @shop.to_slug, @shop.to_param
  end

  test 'Display name method returns shop name' do
    assert_equal @shop.name, @shop.display_name
  end

  test 'Shows error if slug is not unique' do
    @shop2 = Shop.new(name: 'virtualo')
    assert_not @shop2.valid?
    assert_equal ["is not unique enough. Maybe this shop already exists?"], @shop2.errors.messages[:name]
  end
end
