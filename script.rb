## by Hillarioh

module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    i = 0

    enum = to_enum

    while i < size
      yield(enum.next)
      i += 1
    end
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    i = 0

    enum = to_enum

    while i < size
      yield(enum.next, i)

      i += 1
    end
  end

  def my_select
    return enum_for(:my_select) unless block_given?

    arrayed = []

    my_each { |i| arrayed << i if yield(i) == true }

    arrayed
  end

  def my_all?(val = nil)
    return true if size.zero?

    arrayed = []

    if val.class == Regexp
      my_each { |i| arrayed << val.match?(i) }
    elsif block_given?
      my_each { |i| arrayed << yield(i) }

    elsif !val.nil?
      my_each do |i|
        arrayed << if i.is_a? val
                     true
                   else
                     false
                   end
      end
    elsif !val
      my_each do |i|
        arrayed << false if i.nil? || i == false
      end

    end

    state = true
    j = 0

    while j < arrayed.size
      if arrayed[j] != true
        state = false
        break
      end
      j += 1
    end

    state
  end

  def my_any?(val = nil)
    return false if size.zero?

    arrayed = []

    if val.class == Regexp
      my_each { |i| arrayed << val.match?(i) }
    elsif block_given?
      my_each { |i| arrayed << yield(i) }

    elsif !val.nil?
      my_each do |i|
        arrayed << if i.is_a? val
                     true
                   else
                     false
                   end
      end
    elsif !val
      my_each do |i|
        arrayed << false if i.nil? || i == false
      end

    end

    state = false

    j = 0

    while j < arrayed.size
      if arrayed[j] == true
        state = true
        break
      end
      j += 1
    end

    state
  end

  def my_none?(val = nil)
    return true if size.zero?

    arrayed = []

    if val.class == Regexp
      my_each { |i| arrayed << val.match?(i) }
    elsif block_given?
      my_each { |i| arrayed << yield(i) }

    elsif !val.nil?
      my_each do |i|
        arrayed << if i.is_a? val
                     true
                   else
                     false
                   end
      end
    elsif !val
      my_each do |i|
        arrayed << false if i.nil? || i == false
      end

    end

    state = true
    j = 0

    while j < arrayed.size
      if arrayed[j] == true
        state = false
        break

      end
      j += 1

    end

    state
  end

  def my_count(val = 1)
    num = 0

    if val == 1 && block_given?

      arrayed = []
      my_each { |i| arrayed << i if yield(i) == true }

      num = arrayed.size

    elsif val == 1
      track = 0

      i = 0

      while i < size
        track += 1
        i += 1
      end

      num = track
      puts num

    else

      arrayed = my_select { |ent| ent == val }

      num = arrayed.size
    end

    num
  end

  def my_map
    return enum_for(:my_map) unless block_given?

    arrayed = []

    i = 0

    while i < size
      arrayed << yield(self[i])
      i += 1

    end

    arrayed
  end

  def my_inject(val = nil, val2 = nil)
    result = 0

    if (val.is_a? Integer) && (val2.is_a? Symbol)
      unshift(val)
      loc = val2.to_s
      my_inject { |summ, numberr| summ.method(loc).call(numberr) }
    end

    if val.is_a? Symbol
      loc = val.to_s
      my_inject { |summ, numberr| summ.method(loc).call(numberr) }

    end

    if (val.is_a? Integer) && block_given?

      unshift(val) if val.is_a? Integer

    end

    i = 0

    while i < size - 1
      self[i + 1] = yield(self[i], self[i + 1]) if block_given?
      result = self[i + 1] if i == size - 2
      i += 1
    end

    result
  end
end

def multiply_els(my_array)
  my_array.my_inject { |product, number| product * number }
end
