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
        next unless Object.const_defined? t.singularize.camelcase
        @nodes[t] = "<div class='#{t}'><div>#{t}</div><table><tr><th>column</th><th>type</th></tr>#{ApplicationRecord.connection.columns(t).map { |c| "<tr><td>#{c.name}</td><td>#{c.type}</td></tr></div>" }.join('') }"
      end
      @nodes
    end

    def edges
      return @edges unless @edges.empty?

      # TODO: proper signs for each kind of arrows
      tables.each do |t|
        next unless Object.const_defined? t.singularize.camelcase
        klass = t.singularize.camelcase.constantize
        klass.reflections.each do |key, ref|
          key = key.pluralize
          next unless tables.include? key
          exclusive_edge(t, key, ref.macro.to_sym)
        end
      end
      @edges
    end

    def relations
      tables.each do |t|
        next unless Object.const_defined? t.singularize.camelcase
        klass = t.singularize.camelcase.constantize
        klass.reflections.each do |key, ref|
          head = t
          tail = key.pluralize
          relation = ref.macro.to_sym
          next unless tables.include? tail
          @relations[head][relation] << tail
        end
      end
      @relations
    end

    private

    def exclusive_edge(head, tail, relation)
      return if @edges.any? { |e| e[:head] == tail && e[:tail] == head }
      @edges << { head: head, tail: tail, relation: relation, opts: { arrowhead: 'normal', arrowtail: 'undirected'} }
    end

    def initialize_relations
      @relations = {}
      tables.each { |t| @relations[t] = { has_many: [], has_one: [], belongs_to: [] } }
    end

    def tables
      @tables ||= ApplicationRecord.connection.tables - IGNORE_TABLES
    end
  end
end
