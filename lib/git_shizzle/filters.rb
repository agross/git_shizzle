# -*- encoding: utf-8 -*-
module GitShizzle
  module Filters
    def stagable_files
      proc { |status_file| status_file.type == 'M' || status_file.type == 'D' }
    end

    def trackable_files
      proc { |status_file| status_file.untracked }
    end
  end
end
