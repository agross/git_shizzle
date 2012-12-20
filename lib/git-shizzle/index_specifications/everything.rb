# -*- encoding: utf-8 -*-

module GitShizzle
  module IndexSpecifications
    class Everything
      def include?(index)
        true
      end

      def unmatched
        []
      end

      def inspect
        self.class
      end
    end
  end
end
