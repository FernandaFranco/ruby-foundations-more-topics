def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])

    counter += 1
  end

  array
end

def each(array)
  array.each { |value| yield(value) }
end
p each([1, 2, 3, 4, 5]) { |num| puts num }

p each([1, 2, 3, 4, 5]) {|num| "do nothing"}.select{ |num| num.odd? }