module Z3
  class BitvecSort < Sort
    def initialize(n)
      super LowLevel.mk_bv_sort(n)
    end

    def value_class
      BitvecValue
    end

    def from_const(val)
      if val.is_a?(Integer) or val.is_a?(Float)
        new LowLevel.mk_numeral(val.to_s, self)
      else
        raise Z3::Exception, "Cannot convert #{val.class} to #{self.class}"
      end
    end

    def size
      LowLevel.get_bv_sort_size(self)
    end

    def to_s
      "Bitvec(#{size})"
    end

    def inspect
      "BitvecSort(#{size})"
    end

    def >(other)
      raise ArgumentError unless other.is_a?(Sort)
      return true if other.is_a?(IntSort)
      return true if other.is_a?(BitvecSort) and size > other.size
      false
    end

    public_class_method :new
  end
end