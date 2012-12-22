# -*- encoding: utf-8 -*-

require 'thor'
require 'git-shizzle'

module GitShizzle

  class Cli < Thor

    [:stage, :track].each do |action|
      desc "#{action}", "##{action} index [index ...]"
      define_method(action) do |*indexes|
        shizzle.send(action, *indexes)
      end
    end

    private

    def shizzle
      @shizzle ||= GitShizzle::QuickGit.new(GitShizzle::Git::Git.new(Dir.pwd))
    end
  end
end
