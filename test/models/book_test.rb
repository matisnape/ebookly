require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @book = books(:rosario)
  end

  test 'Valid with all data' do
    assert @book.valid?
  end

  test 'Invalid with no title' do
    @book.title = ''
    assert @book.invalid?
  end

  test 'Invalid with no author' do
    @book.author = nil
    assert @book.invalid?
  end

  test 'Invalid with no shop' do
    @book.shop = nil
    assert @book.invalid?
  end

  test 'URL contains book ID and title' do
    assert_equal "#{@book.id}-#{@book.title.parameterize}", @book.to_param
  end
end
