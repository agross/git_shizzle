# -*- encoding: utf-8 -*-

module GitShizzle::Git
  class GitExecuteError < GitShizzle::Error;
  end

  class Git
    def initialize(repo_location)
      @repo_location = repo_location
    end

    def status
      status = command 'status --porcelain -z', [], :verbose => false, :redirect_io => true
      status
        .each_line("\x00")
        .select { |line| line =~ /^[\p{Lu}\x20\?!]{2}\s/ }
        .each_with_index.map do |line, index|
          File.new(:index => index,
                   :status => line[0..1],
                   :path => line[3..-1].delete("\000"),
                   :status_line => line)
      end
    end

    def command(cmd, opts = [], params = { }, &block)
      opts = [opts].flatten.map { |s| escape(s) }.join(' ')

      git_cmd = "git #{cmd} #{opts}"
      echo git_cmd, params.fetch(:verbose, true)

      out = run_command(git_cmd, params, &block)

      if $?.exitstatus > 0
        if $?.exitstatus == 1 && out == ''
          return ''
        end
        raise GitShizzle::Git::GitExecuteError.new(git_cmd + ':' + out.to_s)
      end
      out
    end

    private
    def escape(s)
      escaped = s.to_s.gsub('\'', '\'\\\'\'')
      %Q{"#{escaped}"}
    end

    def run_command(git_cmd, params = { }, &block)
      Dir.chdir(@repo_location) do
        if block_given?
          IO.popen(git_cmd, &block)
        else
          if params.fetch(:redirect_io, false)
            git_cmd += ' 2>&1'
            `#{git_cmd}`.chomp
          else
            system git_cmd
          end
        end
      end
    end

    def echo(msg, verbose)
      $stdout.puts(msg) if verbose && defined?(Thor)
    end
  end
end
