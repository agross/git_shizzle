# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class File
      def initialize(index)
        @index = index
      end

      def include?(index)
        @index == index
      end

      def unmatched

      end

      def inspect
        "#{self.class}: #{@index}"
      end
    end
  end
end
