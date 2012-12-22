# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class IndexSpecification
      def include?(index)
        false
      end

      def register_match(index)
        matches << index
      end

      def matches
        @matches ||= []
      end

      def unmatched
      end
    end
  end
end
