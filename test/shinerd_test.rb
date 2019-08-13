require 'test_helper'

class Shinerd::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Shinerd
  end

  test 'nodes' do
    Rails.application.eager_load!
    graph = Shinerd::Graph.new
    assert_equal ['users', 'posts', 'tags'].sort, graph.nodes.keys.sort
  end

  test 'edges' do
    Rails.application.eager_load!
    graph = Shinerd::Graph.new
    assert_equal [{:head=>"posts", :tail=>"users"}, {:head=>"tags", :tail=>"posts"}], graph.edges
  end
end
