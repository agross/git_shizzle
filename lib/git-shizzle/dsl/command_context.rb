# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class CommandContext
    def initialize(command)
      @command = command
    end

    def applies_to(&block)
      raise ArgumentError.new("#applies_to requires a block") unless block_given?
      @command.set_filter block
    end

    def action(&block)
      raise ArgumentError.new("#action requires a block") unless block_given?
      @command.set_action block
    end
  end
end
