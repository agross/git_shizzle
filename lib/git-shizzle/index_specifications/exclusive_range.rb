# -*- encoding: utf-8 -*-

module GitShizzle::IndexSpecifications
  class ExclusiveRange < Base
    def initialize(index)
      spec = index.split("...")
      assert_numeric index, *spec

      @range = ::Range.new(*spec.map(&:to_i)).to_a[0..-2]
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
