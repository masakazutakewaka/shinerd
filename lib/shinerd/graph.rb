module Shinerd
  class Graph
    IGNORE_TABLES = %w(schema_migrations ar_internal_metadata)

    def initialize
      @nodes = {}
      @edges = []
      initialize_relations
    end

    def nodes
      return @nodes unless @nodes.empty?

      tables.each do |t|
        return unless Object.const_defined? t.singularize.capitalize
        @nodes[t] = "<div class='#{t}'><div>#{t}</div><table><tr><th>column</th><th>type</th></tr>#{ApplicationRecord.connection.columns(t).map { |c| "<tr><td>#{c.name}</td><td>#{c.type}</td></tr></div>" }.join('') }"
      end
      @nodes
    end

    def edges
      return @edges unless @edges.empty?

      tables.each do |t|
        return unless Object.const_defined? t.singularize.capitalize
        klass = t.singularize.capitalize.constantize
        tails = klass.reflections.keys.map(&:pluralize)
        next if tails.empty?
        tails.each { |tail| @edges << { head: t, tail: tail } }
      end
      @edges
    end

    # { users: { parents: ['hoge', 'ia'], childs: ['posts', 'likes'] } }
    def relations
      edges.each do |edge|
        head, tail = edge.values
        @relations[head][:parent] << tail
        @relations[tail][:child] << head
      end
      @relations
    end

    private

    def initialize_relations
      @relations = {}
      tables.each { |t| @relations[t] = { parent: [], child: [] } }
    end

    def tables
      @tables ||= ApplicationRecord.connection.tables - IGNORE_TABLES
    end
  end
end