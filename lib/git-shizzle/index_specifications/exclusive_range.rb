# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class ExclusiveRange < IndexSpecification
      def initialize(index)
        @range = ::Range.new(*index.split("...").map(&:to_i)).to_a[0..-2]
      end

      def include?(index)
        @range.include? index
      end

      def unmatched
        @range - matches
      end

      def inspect
        "#{self.class}: #{@range.inspect}"
      end
    end
  end
end
