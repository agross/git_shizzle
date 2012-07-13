# -*- encoding: utf-8 -*-
module GitShizzle
  class QuickGit
    def initialize(git)
      @git = git
    end

    def stage(index)
      status = @git.status
      indexes = status.find_all { |x,y,file| y == :modified }
      x,y,file = indexes[index-1]
      @git.add(file)
    end
  end
end

