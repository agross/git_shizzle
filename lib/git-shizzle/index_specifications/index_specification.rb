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

      private
      def assert_numeric(index, *spec)
        spec << index if spec.empty?

        all_numeric = spec.all? { |s|
          s.is_a? Numeric or /\d+/.match(s)
        }

        raise IndexSpecificationError, "Could not parse index '#{index}'. Please use numeric indexes or Ruby-style ranges." unless all_numeric
      end
    end
  end
end
