require "spec_helper"

describe Gene do
  it 'can be created by passing a 4-bit string' do
    g = Gene.new '0001'
    g.bits.should == '0001'
    g.value.should == '1'
  end

  it 'can be created by passing a gene character' do
    g = Gene.new '1'
    g.bits.should == '0001'
    g.value.should == '1'
  end

  it 'should expose the bit string and its char value' do
    g = Gene.new '4'
    lambda { g.bits }.should_not raise_error
    lambda { g.value }.should_not raise_error
  end

  it 'should be comparable using ==' do
    g1 = Gene.new '2'
    g2 = Gene.new '0010'
    g1.should == g2
    g1.object_id.should_not == g2.object_id
  end

  it 'should be printable with to_s' do
    Gene.new('2').to_s.should == '2 (0010)'
  end

  it 'should be able to generate a random gene' do
    g1 = Gene.random
  end

  it 'should be deep cloned' do
    g1 = Gene.new('3')
    g2 = g1.clone
    g1.should == g2
    g1.bits.should == g2.bits
    g1.value.should == g2.value
    g1.object_id.should_not == g2.object_id
    g1.bits.object_id == g2.bits.object_id
    g1.value.object_id == g2.value.object_id
  end

  it 'should be frozen' do
    g1 = Gene.new('6')
    lambda { g1.bits[1] = '2' }.should_not raise_error

    g1.freeze
    lambda { g1.bits[1] = '2' }.should raise_error
  end

  it 'should be able to read a bit with []' do
    g1 = Gene.new('0101')
    g1[0].should == '0'
    g1[1].should == '1'
    g1[2].should == '0'
    g1[3].should == '1'
  end

  it 'should be able to swap a bit and return a new object' do
    g1 = Gene.new('1000')
    g2 = g1.swap(0)
    g1[0].should_not == g2[0]

    g2 = g1.swap(0, '0')
    g2[0].should == '0'

    g2 = g1.swap(0, 0)
    g2[0].should == '0'
  end

  it 'should be able to swap a bit and modify itself' do
    g1 = Gene.new '1000'
    original = g1.clone
    g1.swap(0)
    original.should == g1

    g1.swap!(0)
    original.should_not == g1
  end

end

