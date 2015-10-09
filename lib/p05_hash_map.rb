require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    idx = key.hash % num_buckets
    @store[idx].include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets

    idx = key.hash % num_buckets
    @store[idx].insert(key, val)
    @count += 1
  end

  def get(key)
    idx = key.hash % num_buckets
    @store[idx].get(key)
  end

  def delete(key)
    idx = key.hash % num_buckets
    @store[idx].remove(key)
    @count -= 1
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    newsize = num_buckets * 2 + 1
    new_store = Array.new(newsize) { LinkedList.new }
    @store.each do |list|
      list.each do |link|
        new_idx = link.key.hash % newsize
        new_store[new_idx].insert(link.key, link.val)
      end
    end

    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
