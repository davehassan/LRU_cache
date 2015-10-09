class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
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

    if self.empty?
      @head = new_link
      @tail = new_link
    else
      @tail.next = new_link
      new_link.prev = tail
      @tail = new_link
    end

  end

  def remove(key)
    link = @head
    last_link = nil

    until link.nil?
      if link.key == key
        if link == @head
          @head = link.next
          if @head.nil?
            @head = Link.new
            @tail = @head
          else
            @head.prev = nil
          end
        else
          last_link.next = link.next
          link.next.prev = last_link unless link.next.nil?
        end
        return
      end

      last_link = link
      link = link.next
    end
  end

  def each(&prc)
    return if empty?

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
