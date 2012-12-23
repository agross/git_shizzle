# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class CommandCollection
    def initialize(git)
      @git = git
      @commands = []
    end

    def add_command(command)
      @commands << command
    end

    def load
      filenames = ['commands', 'Commands', 'commands.rb', 'Commands.rb'].map do |f|
        "#{File.dirname(__FILE__)}/../../#{f}"
      end
      filename = filenames.find { |f| File.file?(f) }
      raise GitShizzle::Dsl::NoActionsFileFound.new if filename.nil?

      data = File.read(filename)
      dsl.instance_eval(data, "./#{filename}")
    end

    def dsl
      GitShizzle::Dsl::Dsl.new(self, @git)
    end
  end
end
