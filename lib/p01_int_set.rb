class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)

    @store[num] = true
  end

  def remove(num)
    validate!(num)

    @store[num] = false
  end

  def include?(num)
    validate!(num)

    @store[num]
  end

  private

  def is_valid?(num)
    num < @store.size && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)

    num
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num % num_buckets
    @store[idx] << num
  end

  def remove(num)
    idx = num % num_buckets
    @store[idx].delete(num)
  end

  def include?(num)
    idx = num % num_buckets
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    # idx
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    idx = num % num_buckets
    @store[idx]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    newsize = num_buckets * 2 + 1
    new_store = Array.new(newsize) { Array.new }
    @store.flatten.each do |el|
      idx = el % newsize
      new_store[idx] << el
    end
    @store = new_store
  end
end
