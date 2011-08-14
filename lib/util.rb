module Util

  # Convert from a char to a 4-bit binary
  # Good for creating genes by character
  # Ex: '4' => '0100'
  def char2bin(c)
    bits = case c
      when '0' then '0000'
      when '1' then '0001'
      when '2' then '0010'
      when '3' then '0011'
      when '4' then '0100'
      when '5' then '0101'
      when '6' then '0110'
      when '7' then '0111'
      when '8' then '1000'
      when '9' then '1001'
      when '+' then '1010'
      when '-' then '1011'
      when '*' then '1100'
      when '/' then '1101'
      else nil
    end
    bits.clone
  end

  # Convert from a decimal to a 4-bit binary
  # Good for generating random genes
  # Ex 11 => '1011'
  def dec2bin(n)
    bits = case n
      when 0 then '0000'
      when 1 then '0001'
      when 2 then '0010'
      when 3 then '0011'
      when 4 then '0100'
      when 5 then '0101'
      when 6 then '0110'
      when 7 then '0111'
      when 8 then '1000'
      when 9 then '1001'
      when 10 then '1010'
      when 11 then '1011'
      when 12 then '1100'
      when 13 then '1101'
      else nil
    end
    bits.clone
  end

  # Convert from 4-bit binary to a character
  # Good for calculating the value of the gene
  # Ex: '0011' => '3'
  def bin2char(bits)
    c = case bits
      when '0000' then '0'
      when '0001' then '1'
      when '0010' then '2'
      when '0011' then '3'
      when '0100' then '4'
      when '0101' then '5'
      when '0110' then '6'
      when '0111' then '7'
      when '1000' then '8'
      when '1001' then '9'
      when '1010' then '+'
      when '1011' then '-'
      when '1100' then '*'
      when '1101' then '/'
      else nil
    end
    c.clone
  end
end

