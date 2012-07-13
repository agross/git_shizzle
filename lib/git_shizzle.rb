# -*- encoding: utf-8 -*-
require 'git_shizzle/array'

module GitShizzle
  class QuickGit
    def initialize(git)
      @git = git
    end

    def stage(*indexes)
      status = @git.status
      status.find_all { |x,y,file| y != nil }.
        find_by_indexes(indexes).
        partition_on { |_,y,_| y }.
        each { |status, changes| stage_changes(status, changes) }
    end

    def stage_changes(status, changes)
      files = changes.map {|_,_,file| file }
      case status
      when :modified
        @git.add(*files)
      else
        @git.rm(*files)
      end
    end
  end
end

