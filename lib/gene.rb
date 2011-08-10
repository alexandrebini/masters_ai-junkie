require 'util'

class Gene
  extend Util

  attr_reader :bits, :value

  def initialize(args)
    if args.length == 4
      @bits = args.clone
      @value = Gene.bin2char(@bits)
    elsif args.length == 1
      @bits = Gene.char2bin(args)
      @value = args.clone
    end
  end

  def ==(another)
    bits == another.bits
  end

  def to_s
    "#{value} (#{bits})"
  end

  def clone
    Gene.new(bits)
  end

  def freeze
    bits.freeze
    value.freeze
  end

  def [](index)
    bits[index]
  end

  def swap(index, value=nil)
    swap_impl(index, value, false)
  end

  def swap!(index, value=nil)
    swap_impl(index, value, true)
  end


  def self.random
    Gene.new dec2bin(rand 16)
  end

  private
    def swap_impl(index, value=nil, modified=false)
      if value.nil?
        old_value = bits[index]
        new_value = old_value == '0' ? '1' : '0'
      else
        new_value = value.to_s
      end

      if not modified
        new_bits = bits.clone
        new_bits[index] = new_value
        Gene.new new_bits
      else
        bits[index] = new_value
        value = Gene.bin2char(bits)
        self
      end
    end
end

