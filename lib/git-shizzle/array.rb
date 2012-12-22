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
end
