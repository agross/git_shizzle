# -*- encoding: utf-8 -*-
require 'git_shizzle/array'

module GitShizzle
  class QuickGit
    def initialize(git)
      @git = git
    end

    def stage(*indexes)
      changes_for(indexes) { |x,y,file| y != nil }.
        each { |status, changes| stage_changes(status, changes) }
    end

    def track(*indexes)
      changes_for(indexes) { |x,y,file| y == :new }.
        each { |status, changes| stage_changes(status, changes) }
    end

    private

    def changes_for(indexes, &filter)
      @git.status.
        find_all(&filter).
        find_by_indexes(indexes).
        partition_on { |_,y,_| y }
    end

    def stage_changes(status, changes)
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

