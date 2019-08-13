module Shinerd
  class Graph
    IGNORE_TABLES = %w(schema_migrations ar_internal_metadata)

    def nodes
      nodes = {}
      tables.each do |t|
        return unless Object.const_defined? t.singularize.capitalize
        nodes[t] = "<div class='#{t}'><div>#{t}</div><table><tr><th>column</th><th>type</th></tr>#{ApplicationRecord.connection.columns(t).map { |c| "<tr><td>#{c.name}</td><td>#{c.type}</td></tr></div>" }.join('') }"
      end
      nodes
    end

    def edges
      edges = []
      tables.each do |t|
        return unless Object.const_defined? t.singularize.capitalize
        klass = t.singularize.capitalize.constantize
        tails = klass.reflections.keys.map(&:pluralize)
        next if tails.empty?
        tails.each { |tail| edges << { head: t, tail: tail } }
      end
      #require 'byebug'; byebug
      edges
    end

    private

    def tables
      @tables ||= ApplicationRecord.connection.tables - IGNORE_TABLES
    end
  end
end