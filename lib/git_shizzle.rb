# -*- encoding: utf-8 -*-

require 'active_support/core_ext/enumerable.rb'
require 'git-shizzle/error'
require 'git-shizzle/dsl'
require 'git-shizzle/git'
require 'git-shizzle/index_specifications'

module GitShizzle

  class QuickGit
    def initialize(git = Git::Git.new(Dir.pwd))
      @git = git
      @commands = GitShizzle::Dsl::CommandCollection.new
      @commands.load
    end

    def run(command, *indexes)
      cmd = @commands.find command
      files = changes_for(indexes, cmd)

      cmd.invoke @git, files
    end

    def method_missing(sym, *args)
      run(sym, *args)
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
  end
end
