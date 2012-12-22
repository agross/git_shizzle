# -*- encoding: utf-8 -*-

module GitShizzle::IndexSpecifications
  class Everything < IndexSpecification
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
