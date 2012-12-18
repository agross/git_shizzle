# -*- encoding: utf-8 -*-
require "git-shizzle/git/file"

module GitShizzle
  class GitExecuteError < StandardError
  end

  class Git
    def initialize(dir)
      @repository = dir
    end

    def status
      files = []

      Dir.chdir(@repository) do
        status = `git status --porcelain -z`
        status.
          each_line("\x00").
          each_with_index { |line, index|
            files << File.new(
            {
              :index => index,
              :status => line[0..1],
              :path => line[3..-1].delete("\000")
            })
          }
      end

      files
    end

    def add(files)
      command "add", files
    end

    def remove(files)
      command "rm", files
    end

    def command(cmd, opts = [], &block)
      opts = [opts].flatten.map { |s| escape(s) }.join(' ')
      git_cmd = "git #{cmd} #{opts} 2>&1"

      out = run_command(git_cmd, &block)

      if $?.exitstatus > 0
        if $?.exitstatus == 1 && out == ''
          return ''
        end
        raise GitShizzle::GitExecuteError.new(git_cmd + ':' + out.to_s)
      end
      out
    end

    def escape(s)
      escaped = s.to_s.gsub('\'', '\'\\\'\'')
      %Q{"#{escaped}"}
    end

    def run_command(git_cmd, &block)
      if block_given?
        IO.popen(git_cmd, &block)
      else
        `#{git_cmd}`.chomp
      end
    end
  end
end
