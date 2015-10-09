class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    link = @head
    until link.next == nil
      link = link.next
    end

    link
  end

  def empty?
    @head.key.nil?
  end

  def get(key)
    return nil if self.empty?

    link = @head

    until link.nil?
      return link.val if link.key == key
      link = link.next
    end

    nil
  end

  def include?(key)
    unless empty?
      link = @head

      until link.nil?
        return true if link.key == key
        link = link.next
      end
    end

    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)

    self.empty? ? @head = new_link : self.last.next = new_link
  end

  def remove(key)
    link = @head
    last_link = nil

    until link.nil?
      if link.key == key
        link == @head ? @head = link.next : last_link.next = link.next
        return
      end

      last_link = link
      link = link.next
    end
  end

  def each(&prc)
    link = @head

    until link.nil?
      prc.call(link)
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
