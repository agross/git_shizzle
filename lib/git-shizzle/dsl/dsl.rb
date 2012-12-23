# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class Dsl
    def initialize(commands)
      @commands = commands
    end

    def desc(description)
      @description = description
    end

    def command(identifier, &block)
      raise ArgumentError.new("#command requires a block") unless block_given?

      command = Command.new(identifier, @description, block)
      @commands.add_command(command)

      reset_description
    end

    private
    def reset_description
      @description = nil
    end
  end
end
