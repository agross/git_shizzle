# -*- encoding: utf-8 -*-

module GitShizzle::Git
  class GitExecuteError < StandardError
    include GitShizzle::Error
  end

  class Git
    def initialize(repo_location)
      @repo_location = repo_location
    end

    def status
      Dir.chdir(@repo_location) do
        status = `git status --porcelain -z`
        status.
          each_line("\x00").
          each_with_index.map do |line, index|
            File.new(
              :index => index,
              :status => line[0..1],
              :path => line[3..-1].delete("\000"))
          end
      end
    end

    def add(files)
      command 'add', files
    end

    def remove(files)
      command 'rm', files
    end

    def command(cmd, opts = [], &block)
      opts = [opts].flatten.map { |s| escape(s) }.join(' ')
      git_cmd = "git #{cmd} #{opts} 2>&1"

      echo git_cmd[0..-5]

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

    def echo(msg)
      puts(msg) if defined?(Thor)
    end
  end
end
