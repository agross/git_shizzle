# -*- encoding: utf-8 -*-

module GitShizzle::IndexSpecifications
  class Combined
    def initialize(specs)
      @specs = specs
    end

    def include?(index)
      index = humanize index

      @specs.any? do |spec|
        spec.include? index
      end
    end

    def register_match(index)
      index = humanize index

      @specs.each do |spec|
        spec.register_match index
      end
    end

    def unmatched
      []
    end

    def apply(files)
      result = files.each_with_index.map do |element, index|
        next unless include? index
        register_match index

        element
      end.compact

      unmatched_indexes = @specs.map do |spec|
        spec.unmatched
      end.flatten.compact.uniq.sort

      raise IndexSpecificationError, "Could not determine files for indexes: #{unmatched_indexes.join(', ')}" if unmatched_indexes.any?

      result
    end

    private
    def humanize(index)
      index + 1
    end
  end
end
