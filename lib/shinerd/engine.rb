require_relative 'graph'

module Shinerd
  class Engine < ::Rails::Engine
    isolate_namespace Shinerd
  end
end
