# -*- encoding: utf-8 -*-
module GitShizzle
  module Filters
    def stageable_files
      proc { |file| file.work_tree_status == :modified || file.work_tree_status == :deleted }
    end

    def trackable_files
      proc { |file| file.index_status == :untracked || file.work_tree_status == :untracked }
    end
  end
end
