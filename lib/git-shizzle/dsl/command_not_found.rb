# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class CommandNotFound < GitShizzle::Error
    def initialize(identifier)
      super "Could not find '#{identifier}' command."
    end
  end
end
