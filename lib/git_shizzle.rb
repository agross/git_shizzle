# -*- encoding: utf-8 -*-

require 'active_support/core_ext/enumerable.rb'
require 'git-shizzle/error'
require 'git-shizzle/dsl'
require 'git-shizzle/filters'
require 'git-shizzle/git'
require 'git-shizzle/index_specifications'

module GitShizzle

  class QuickGit
    include Filters

    def initialize(git = Git::Git.new(Dir.pwd))
      @git = git
      @commands = GitShizzle::Dsl::CommandCollection.new(git)
      @commands.load
    end

    def stage(*indexes)
      command = @commands.find :stage
      files = changes_for(indexes, command)

      invoke files, :stage
    end

    def track(*indexes)
      command = @commands.find :track
      files = changes_for(indexes, command)

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

    def changes_for(indexes, command)
      files = command.applicable_files(@git.status)

      spec = create_index_specification indexes
      spec.apply files
    end

    def invoke(files, action)
      raise GitShizzle::IndexSpecifications::NoFilesError.new(action) if files.empty?

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
