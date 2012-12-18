# -*- encoding: utf-8 -*-

module GitShizzle
  class File
    attr_reader :index_status, :work_tree_status, :path

    def initialize(params)
      @index_status = map params[:status][0]
      @work_tree_status = map params[:status][1]
      @path = params[:path]
    end

    def map(status_code)
      case status_code
        when '?'
          :untracked
        when 'M'
          :modified
        when 'A'
          :added
        when 'D'
          :deleted
        when 'C'
          :copied
        when 'R'
          :renamed
        when 'U'
          :unmerged
      end
    end
  end
end
