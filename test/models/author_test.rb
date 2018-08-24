require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  setup do
    @author = authors(:jakub_zulczyk)
  end

  test 'Valid with all data' do
    assert @author.valid?
  end

  test 'Invalid with no first name' do
    @author.first_name = ''
    assert @author.invalid?
    assert_equal ["can't be blank"], @author.errors.messages[:first_name]
  end

  test 'Invalid with no last name' do
    @author.last_name = ''
    assert @author.invalid?
    assert_equal ["can't be blank"], @author.errors.messages[:last_name]
  end
end
