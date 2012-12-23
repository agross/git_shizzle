# -*- encoding: utf-8 -*-

module GitShizzle::Git
  class File
    attr_reader :index_status, :work_tree_status, :path

    def initialize(params)
      @index_status = map params[:status][0]
      @work_tree_status = map params[:status][1]
      @path = params[:path]
    end

    def inspect
      "Path: #{path}: work tree #{@work_tree_status}, index #{@index_status}"
    end

    private
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
        when ' '
          nil
        else
          raise "Unexpected file status code '#{status_code}'"
      end
    end
  end
end
