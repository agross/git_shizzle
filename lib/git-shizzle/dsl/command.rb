# -*- encoding: utf-8 -*-

module GitShizzle::Dsl
  class Command
    attr_reader :identifier, :description

    def initialize( identifier, description, block)
      @identifier = identifier
      @description = description

      GitShizzle::Dsl::CommandContext.new(self).instance_eval &block
    end

    def applicable_files(git_status)
      git_status.find_all do |file|
        @filter.call(file.index_status, file.work_tree_status, file.path)
      end
    end

    def invoke(git, files)
      raise GitShizzle::IndexSpecifications::NoFilesError.new(@identifier) if files.empty?

      files.
        map { |file| @action.call(file.index_status, file.work_tree_status, file.path) }.
        group_by { |group| group[0] }.
        each_pair { |command, command_paths| git.command command, paths_for(command_paths) }
    end

    def paths_for(command_paths)
      command_paths.map { |a| a[1] }
    end

    def set_filter(block)
      @filter = block
    end

    def set_action(block)
      @action = block
    end
  end
end
