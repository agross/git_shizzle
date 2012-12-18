# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'thor'
require 'git-shizzle'

class GitQuickApp < ::Thor
  USAGE = <<-EOH
  EOH

  desc "#stage index [index ...]", USAGE
  method_options :dry_run => :boolean
  def stage(*indexes)
    shizzle.stage(indexes.map(&:to_i))
  end

  desc "#track index [index ...]", USAGE
  method_options :dry_run => :boolean
  def track(*indexes)
    shizzle.track(indexes.map(&:to_i))
  end

  desc "Displays the help", ""
  def help
    puts USAGE
  end

  private

  def shizzle
    @shizzle ||= begin
      git = GitShizzle::Git.open(Dir.pwd)
      GitShizzle::QuickGit.new(git)
    end
  end
end
