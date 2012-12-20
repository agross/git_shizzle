# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class Range
      def initialize(index)
        @range = ::Range.new(*index.split("..").map(&:to_i)).to_a
      end

      def include?(index)
        @range.include? index
      end

      def inspect
        "#{self.class}: #{@range.inspect}"
      end
    end
  end
end
