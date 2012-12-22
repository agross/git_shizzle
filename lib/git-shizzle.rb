# -*- encoding: utf-8 -*-

require 'active_support/core_ext/enumerable.rb'
require 'git-shizzle/error'
require 'git-shizzle/filters'
require 'git-shizzle/git'
require 'git-shizzle/index_specifications'

module GitShizzle

  class IndexSpecificationError < StandardError; end

  class QuickGit
    include Filters

    def initialize(git)
      @git = git
    end

    def stage(*indexes)
      files = changes_for(indexes, &stageable_files)

      invoke files, :stage
    end

    def track(*indexes)
      files = changes_for(indexes, &trackable_files)

      invoke files, :track
    end

    private
    def create_index_specification(indexes)
      specs = indexes.map { |index|
        case index
          when /\.\.\./
            IndexSpecifications::ExclusiveRange.new(index)
          when /\.\./
            IndexSpecifications::Range.new(index)
          when /\./
            IndexSpecifications::Everything.new
          else
            IndexSpecifications::File.new(index)
        end
      }

      IndexSpecifications::Combined.new specs
    end

    def changes_for(indexes, &filter)
      files = @git.status.find_all(&filter)

      spec = create_index_specification indexes
      spec.apply files
    end

    def invoke(files, action)
      raise GitShizzle::IndexSpecifications::IndexSpecificationError, "No files for action #{action}." if files.empty?

      files.
        map { |f| f.action @git, action }.
        group_by { |file| file.action }.
        each_pair { |method, a| method.call paths_for(a) }
    end

    def paths_for(action)
      action.map { |a| a.path }
    end
  end
end
