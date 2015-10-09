class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    h = 0
    self.each_with_index do |el, idx|
      h += el.hash * 17 ** idx + 1
    end

    h
  end
end

class String
  def hash
    arr = self.split("").map { |char| char.ord.hash }
    arr.hash
  end
end

class Hash
  def hash
    h = 0
    self.each_pair do |key, val|
      h += key.to_s.hash + 17 * val.hash
    end

    h
  end
end
