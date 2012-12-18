# -*- encoding: utf-8 -*-
require 'git-shizzle/git/git'
require 'git-shizzle/array'
require 'git-shizzle/filters'

module GitShizzle
  class QuickGit
    include Filters

    def initialize(git)
      @git = git
    end

    def stage(indexes)
      files = changes_for(indexes, &stageable_files)

      invoke files, :stage
    end


    def track(indexes)
      files = changes_for(indexes, &trackable_files)

      invoke files, :track
    end

    private
    def changes_for(indexes, &filter)
      @git.status.
        find_all(&filter).
        find_by_indexes(indexes)
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

