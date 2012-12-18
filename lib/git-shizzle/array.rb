# -*- encoding: utf-8 -*-
class Array
  def partition_on(&key_selector)
    h = {}
    self.each do |value|
      values = h[key_selector.call(value)] ||= []
      values << value
    end
    h
  end

  def find_by_indexes(indexes)
    result = []
    self.each_with_index do |element, i|
      result << element if indexes.include?(i + 1)
    end
    result
  end
end
