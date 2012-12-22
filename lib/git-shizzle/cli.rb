# -*- encoding: utf-8 -*-

require 'thor'
require 'git-shizzle'

module GitShizzle
  class Cli < Thor
    USAGE = <<-EOH
    Hello, world.
    EOH

    [:stage, :track].each do |action|
      desc "#{action}", "#{action} file(s) by index or range"
      define_method(action) do |*indexes|
        begin
          shizzle.send(action, *indexes)
        rescue GitShizzle::Error => e
          puts e.message
        end
      end
    end

    desc "help", "displays the help"
    def help
      puts USAGE
    end

    private

    def shizzle
      @shizzle ||= GitShizzle::QuickGit.new
    end
  end
end
