# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
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
        result = []

        files.each_with_index do |element, index|
          next unless include? index
          register_match index

          result << element
        end

        unmatched_indexes = @specs.map { |spec|
          spec.unmatched
        }.flatten.compact.uniq.sort

        raise IndexSpecificationError, "Could not determine files for indexes: #{unmatched_indexes.join(', ')}" if unmatched_indexes.any?

        result
      end

      private
      def humanize(index)
        index + 1
      end
    end
  end
end
