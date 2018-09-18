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

  test 'URL method contains author ID and author name' do
    assert_equal "#{@author.id}-#{@author.display_name.parameterize}", @author.to_param
  end

  test 'display_name method returns formatted name' do
    assert_equal "#{@author.last_name}, #{@author.first_name}", @author.display_name
  end
end
