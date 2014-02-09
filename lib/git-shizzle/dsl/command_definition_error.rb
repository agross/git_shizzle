# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class CommandDefinitionError < GitShizzle::Error
    def initialize(command_or_identifier, message)
      if command_or_identifier.respond_to? :identifier
        identifier = command_or_identifier.identifier
      else
        identifier = command_or_identifier
      end

      super "Command '#{identifier}': #{message}"
    end
  end
end
