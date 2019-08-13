require 'test_helper'

class Shinerd::Test < ActiveSupport::TestCase
  Rails.application.eager_load!
  @@graph = Shinerd::Graph.new

  test "truth" do
    assert_kind_of Module, Shinerd
  end

  test 'nodes' do
    assert_equal ['users', 'posts', 'tags'].sort, @@graph.nodes.keys.sort
  end

  test 'edges' do
    assert_equal [{:head=>"posts", :tail=>"users"}, {:head=>"tags", :tail=>"posts"}], @@graph.edges
  end

  test 'relations' do
    expected = {"users"=>{:parent=>[], :child=>["posts"]}, "posts"=>{:parent=>["users"], :child=>["tags"]}, "tags"=>{:parent=>["posts"], :child=>[]}}
    assert_equal expected, @@graph.relations
  end
end