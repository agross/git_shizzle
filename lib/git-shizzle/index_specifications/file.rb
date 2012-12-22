# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class File < IndexSpecification
      def initialize(index)
        assert_numeric index
        @index = index
      end

      def include?(index)
        @index == index
      end

      def unmatched
        ([] << @index) - matches
      end

      def inspect
        "#{self.class}: #{@index}"
      end
    end
  end
end
