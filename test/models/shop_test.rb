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
end
