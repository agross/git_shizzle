# -*- encoding: utf-8 -*-

require 'thor'
require 'git-shizzle'

module GitShizzle
  class Cli < ::Thor
    USAGE = <<-EOH
    Hello, world.
    EOH

    desc "stage", "Stage file(s) by index or range"
    method_options :dry_run => :boolean
    def stage(*indexes)
      shizzle.stage indexes
    end

    desc "track", "Track file(s) by index or range"
    method_options :dry_run => :boolean
    def track(*indexes)
      shizzle.track indexes
    end

    desc "help", "Displays the help"
    def help
      puts USAGE
    end

    private
    def shizzle
      @shizzle ||= begin
        git = GitShizzle::Git::Git.new(Dir.pwd)
        GitShizzle::QuickGit.new(git)
      end
    end
  end
end
