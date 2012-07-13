# -*- encoding: utf-8 -*-
module GitShizzle
  module Filters
    ALLOWED_STAGE_OPS = [:modified, :deleted]

    def stagable_files
      proc { |_,y,_| ALLOWED_STAGE_OPS.include?(y) }
    end

    def trackable_files
      proc { |_,y,_| y == :new }
    end
  end
end
