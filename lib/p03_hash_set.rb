require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    self[key.hash] << key.hash
    @count += 1
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    self[key.hash].delete(key.hash)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
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
