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
      files = changes_for(indexes, &stageable_files).
        map { |file| file.path }

      raise "No stageable files" if files.empty?

      @git.add files
    end

    def track(indexes)
      files = changes_for(indexes, &trackable_files).
        map { |file| file.path }

      raise "No untracked files" if files.empty?

      @git.add files
    end

    private

    def changes_for(indexes, &filter)
      @git.status.
        find_all(&filter).
        find_by_indexes(indexes)
        #stat.partition_on { |file| file.type }
    end

    def add_to_index(status, changes)
      files = changes.map { |file| file.path }
      case status
      when 'M', nil
        @git.add(files)
      else
        @git.remove(files)
      end
    end
  end
end

