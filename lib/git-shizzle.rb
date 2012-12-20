# -*- encoding: utf-8 -*-

require 'git-shizzle/array'
require 'git-shizzle/filters'
require 'git-shizzle/git'
require 'git-shizzle/index_specifications'

module GitShizzle
  class IndexSpecificationError < StandardError
  end

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
    def merge(indexes)
      indexes.map { |index|
        case index
          when /\.\.\./
            #IndexSpecifications::ExclusiveRange.new(index)
            ::Range.new(*index.split("...").map(&:to_i)).to_a[0..-2]
          when /\.\./
            #IndexSpecifications::Range.new(index)
            ::Range.new(*index.split("..").map(&:to_i)).to_a
          when /\./
            raise "Not supported"
          else
            #IndexSpecifications::File.new(index)
            index.to_i
        end
      }.flatten.uniq
    end

    def changes_for(indexes, &filter)
      indexes = merge indexes

      files, unmatched_indexes = @git.status.
        find_all(&filter).
        find_by_indexes(indexes)

      raise IndexSpecificationError, "Could not determine files for indexes: #{unmatched_indexes.join(', ')}" if unmatched_indexes.any?

      files
    end

    def invoke(files, action)
      raise "No files for action #{action}" if files.empty?

      files.
        map { |f| f.action @git, action }.
        partition_on { |file| file.action }.
        each_pair { |method, action| method.call paths_for(action) }
    end

    def paths_for(action)
      action.map { |a| a.path }
    end
  end
end
