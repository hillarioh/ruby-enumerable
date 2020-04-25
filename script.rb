## by Hillarioh

module Enumerable
  def my_each
    i = 0

    while i < size
      block_given? ? yield(self[i]) : break
      i += 1
    end
  end

  def my_each_with_index
    i = 0

    while i < size
      block_given? ? yield(self[i], i) : break
      i += 1
    end
  end

  def my_select
    arrayed = []
    my_each { |i| arrayed << i if yield(i) == true }
    arrayed
  end

  def my_all?
    arrayed = []
    my_each { |i| arrayed << (yield(i) == true) }
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

  def my_any?
    arrayed = []

    my_each { |i| arrayed << (yield(i) == true) }

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

  def my_none?
    arrayed = []

    my_each { |i| arrayed << (yield(i) == true) }

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
    arrayed = []

    i = 0

    while i < size
      arrayed << yield(self[i]) if block_given?
      i += 1

    end

    arrayed
  end

  def my_inject(val = 1)
    result = 0

    unshift(val) if val != 1

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

# Test for my_each

puts '>>>Test for my_each'
%w[janet junior shem].my_each { |elem| puts elem }
puts ''

puts '>>>Test for my_each_with_index'
fruits = %w[apple banana strawberry pineapple]
fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }
puts ''

puts '>>>Test for select'
friends = %w[Sharon Leo Leila Brian Arun]
my_friends = friends.my_select { |friend| friend != 'Brian' }
print my_friends
puts ''

puts '>>>Test for all?'
ages = [19, 59, 70, 23, 140]
valid = ages.my_all? { |age| age > 10 && age <= 222 }
puts valid
puts ''

puts '>>>Test for any?'
pet_names = %w[pluto scooby nyan]
find_scooby = pet_names.my_any? { |pet| pet == 'scoobyy' }
puts find_scooby
puts ''

puts '>>>Test for none?'
animals = %w[ant bear cat]
wrd_len = animals.my_none? { |word| word.length == 5 }
puts wrd_len

wrd_len2 = animals.my_none? { |word| word.length >= 4 }
puts wrd_len2
puts ''

puts '>>>Test for count'
nomb = [1, 2, 3, 2, 2, 3, 2, 3]
puts nomb.count
puts nomb.my_count(2)
puts nomb.my_count(&:even?)
puts ''

puts '>>>Test for map'
salaries = [1200, 1500, 1100, 1800]
sorted = salaries.my_map { |salary| salary - 700 }
puts sorted
puts ''

puts '>>>Test for inject'
listed = [3, 6, 37, 45, 10]
injecteda = listed.my_inject(2) { |sum, number| sum + number }
puts injecteda

injected = listed.my_inject { |sum, number| sum + number }
puts injected
puts ''

puts '>>>Test for multuply_els'
puts multiply_els([3, 6, 37, 45, 10])
