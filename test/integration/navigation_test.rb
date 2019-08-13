require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'models and edges' do
    visit '/shinerd'

    byebug
    assert has_content? 'users'
    assert has_content? 'posts'
    assert has_content? 'tags'
  end
end
