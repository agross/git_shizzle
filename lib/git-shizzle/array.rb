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
    matched_indexes = []

    self.each_with_index do |element, index|
      next unless indexes.include? humanize(index)

      matched_indexes << humanize(index)
      result << element
    end

    [result, indexes - matched_indexes]
  end

  private
  def humanize(index)
    index + 1
  end
end
