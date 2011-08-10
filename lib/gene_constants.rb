require 'gene'

module GeneConstants

  def const_missing(args)
    case args.to_s
      when 'Zero' then Gene.new('0')
      when 'One' then Gene.new('1')
      when 'Two' then Gene.new('2')
      when 'Three' then Gene.new('3')
      when 'Four' then Gene.new('4')
      when 'Five' then Gene.new('5')
      when 'Six' then Gene.new('6')
      when 'Seven' then Gene.new('7')
      when 'Eight' then Gene.new('8')
      when 'Nine' then Gene.new('9')
      when 'Plus' then Gene.new('+')
      when 'Minus' then Gene.new('-')
      when 'Times' then Gene.new('*')
      when 'Div' then Gene.new('/')
      else super
    end
  end

end

Object.send :extend, GeneConstants

