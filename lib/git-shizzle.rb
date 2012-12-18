# -*- encoding: utf-8 -*-
require 'git-shizzle/array'
require 'git-shizzle/filters'

module GitShizzle
  class QuickGit
    include Filters

    def initialize(git)
      @git = git
    end

    def stage(indexes)
      changes_for(indexes, &stagable_files).
        each { |type, changes| add_to_index(type, changes) }
    end

    def track(indexes)
      changes_for(indexes, &trackable_files).
        each { |type, changes| add_to_index(type, changes) }
    end

    private

    def changes_for(indexes, &filter)
      @git.status.
        find_all(&filter).
        find_by_indexes(indexes).
        partition_on { |status_file| status_file.type }
    end

    def add_to_index(status, changes)
      files = changes.map { |status_file| status_file.path }
      case status
      when 'M', nil
        @git.add(files)
      else
        @git.remove(files)
      end
    end
  end
end

