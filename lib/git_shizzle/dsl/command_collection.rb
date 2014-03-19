# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class CommandCollection
    def initialize
      @commands = []
    end

    def add_command(command)
      raise DuplicateCommandDefinitionError.new(command) if @commands.any? { |c| c.identifier == command.identifier}

      @commands << command
    end

    def load(contents = nil)
      data = contents

      unless data
        filenames = ['commands', 'Commands', 'commands.rb', 'Commands.rb'].map do |f|
          "#{File.dirname(__FILE__)}/../../#{f}"
        end
        filename = filenames.find { |f| File.file?(f) }
        raise GitShizzle::Dsl::NoCommandFileFoundError.new if filename.nil?

        data = File.read(filename)
      end

      dsl.instance_eval(data, "./#{filename}")
    end

    def each(&block)
      @commands.each do |command|
        if block_given?
          block.call command
        else
          yield command
        end
      end
    end

    def find(identifier)
      @commands.find { |c| c.identifier == identifier } or raise GitShizzle::Dsl::CommandNotFoundError.new(identifier)
    end

    private
    def dsl
      GitShizzle::Dsl::Dsl.new(self)
    end
  end
end
