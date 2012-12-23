# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class Command
    attr_reader :identifier, :description

    def initialize(identifier, description, block)
      @identifier = identifier
      @description = description

      GitShizzle::Dsl::CommandContext.new(self).instance_eval &block
    end

    def applicable_files(git_status)
      git_status.find_all do |file|
        @filter.call(file.index_status, file.work_tree_status, file.path)
      end
    end

    def set_filter(block)
      @filter = block
    end

    def set_action(block)
      @action = block
    end
  end
end
