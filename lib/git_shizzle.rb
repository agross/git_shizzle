# -*- encoding: utf-8 -*-
require 'git_shizzle/array'
require 'git_shizzle/filters'

module GitShizzle
  class QuickGit
    include Filters

    def initialize(git)
      @git = git
    end

    def stage(*indexes)
      changes_for(indexes, &stagable_files).
        each { |status, changes| add_to_index(status, changes) }
    end

    def track(*indexes)
      changes_for(indexes, &trackable_files).
        each { |status, changes| add_to_index(status, changes) }
    end

    private

    def changes_for(indexes, &filter)
      @git.status.
        find_all(&filter).
        find_by_indexes(indexes).
        partition_on { |_,y,_| y }
    end

    def add_to_index(status, changes)
      files = changes.map {|_,_,file| file }
      case status
      when :modified, :new
        @git.add(*files)
      else
        @git.rm(*files)
      end
    end
  end
end

