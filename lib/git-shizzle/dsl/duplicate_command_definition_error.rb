# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class DuplicateCommandDefinitionError < GitShizzle::Error
    def initialize(command)
      super "The '#{command.identifier}' was specified twice."
    end
  end
end
