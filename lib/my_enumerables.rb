module Enumerable
  # Your code goes here
  def my_all?
    return true unless block_given?

    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    return false unless block_given?

    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    return length unless block_given?

    count = 0
    my_each do |element|
      count += 1 if yield(element)
    end
    count
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    count = 0
    my_each do |element|
      yield(element, count)
      count += 1
    end
    self
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    my_each do |element|
      result << yield(element)
    end
    result
  end

  def my_none?
    return true unless block_given?

    my_each do |element|
      return false if yield(element)
    end
    true
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each do |element|
      result << element if yield(element)
    end
    result
  end

  def my_inject(initial = nil)
    if initial
      accumulator = initial
      my_each do |element|
        accumulator = yield(accumulator, element)
      end
    else
      accumulator = first
      my_each_with_index do |element, index|
        next if index.zero?

        accumulator = yield(accumulator, element)
      end
    end
    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for i in 0...length # rubocop:disable Style/For
      yield self[i]
    end
    self
  end
end
