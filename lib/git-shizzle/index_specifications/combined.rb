# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class Combined
      def initialize(*specs)
        @specs = specs
      end

      def include?(index)
        index = humanize index

        @specs.any? do |spec|
          spec.include? index
        end
      end

      def unmatched
        []
      end

      private
      def humanize(index)
        index + 1
      end
    end
  end
end
