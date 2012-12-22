# -*- encoding: utf-8 -*-

module GitShizzle::Git
  class FileAction
    attr_reader :action, :path

    def initialize(action, path)
      @action = action
      @path = path
    end
  end
end