## by Hillarioh
#../script.rb
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
        arrayed << if i.class == val.class
                     (i == val)

                   elsif val.class == Class
                     if i.is_a? val
                       true
                     else
                       false
                     end
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
        arrayed << if i.class == val.class
                     (i == val)

                   elsif val.class == Class
                     if i.is_a? val
                       true
                     else
                       false
                     end
                   else
                     false
                   end
      end

    elsif !val
      my_each do |i|
        arrayed << (i == false || i.nil? ? false : true)
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

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
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

  def my_inject(initial = nil, second = nil)
    arr = is_a?(Array) ? self : to_a
    sym = initial if initial.is_a?(Symbol) || initial.is_a?(String)
    acc = initial if initial.is_a? Integer

    if initial.is_a?(Integer)
      sym = second if second.is_a?(Symbol) || second.is_a?(String)
    end

    if sym
      arr.my_each { |x| acc = acc ? acc.send(sym, x) : x }
    elsif block_given?
      arr.my_each { |x| acc = acc ? yield(acc, x) : x }
    end
    acc
  end
end

def multiply_els(my_array)
  my_array.my_inject { |product, number| product * number }
end
