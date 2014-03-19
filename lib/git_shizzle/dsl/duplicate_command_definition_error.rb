# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class DuplicateCommandDefinitionError < GitShizzle::Error
    def initialize(command)
      super "The '#{command.identifier}' command was specified twice."
    end
  end
end
