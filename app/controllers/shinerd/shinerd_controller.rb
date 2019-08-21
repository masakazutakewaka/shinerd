module Shinerd
  class ShinerdController < ApplicationController
    def index
      Rails.application.eager_load!

      graph = Shinerd::Graph.new
      @nodes = graph.nodes
      @edges = graph.edges
      @relations = graph.relations

      render layout: false
    end
  end
end
