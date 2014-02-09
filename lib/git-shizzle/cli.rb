# -*- encoding: utf-8 -*-

require 'thor'
require 'git_shizzle'

module GitShizzle
  class Cli < Thor
    USAGE = <<-EOH
    Hello, world.
    EOH

    @commands = GitShizzle::Dsl::CommandCollection.new
    @commands.load

    @commands.each do |command|
      desc "#{command.identifier}", "#{command.description} by index or range"
      define_method(command.identifier) do |*indexes|
        begin
          shizzle.send(:run, command.identifier, *indexes)
        rescue GitShizzle::Error => e
          puts e.message
        end
      end
    end

    desc 'help', 'displays the help'
    def help
      puts USAGE
    end

    private

    def shizzle
      @shizzle ||= GitShizzle::QuickGit.new
    end
  end
end
