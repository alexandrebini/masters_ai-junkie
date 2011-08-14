require "spec_helper"

describe Chromosome do
  it 'should be able to generate based on target' do
    lambda{ Chromosome.new }.should_not raise_error
  end

  it 'should be able to get the expression' do
    lambda{ Chromosome.new.expression }.should_not raise_error
  end

  it 'should be able to check num-oper-num-oper-num pattern' do
    Chromosome.new(:genes => [Gene.new('1'), Gene.new('/'), Gene.new('2')]).expression.should == '1/2'
    Chromosome.new(:genes => [Gene.new('1'), Gene.new('/'), Gene.new('2'), Gene.new('-')]).expression.should == '1/2'
    Chromosome.new(:genes => [Gene.new('/'), Gene.new('2'), Gene.new('/')]).expression.should == '2'
    Chromosome.new(:genes => [Gene.new('5'), Gene.new('+'), Gene.new('999')]).expression.should == '5'
    Chromosome.new(:genes => [Gene.new('/'), Gene.new('/'), Gene.new('*')]).expression.should be_nil

    gene = Chromosome.new :genes => [Gene.new('1'), Gene.new('-'), Gene.new('2'), Gene.new('*'), Gene.new('5') ]
    lambda{ eval gene.expression }.should_not raise_error
    eval(gene.expression).should == 1-2*5
  end

  it 'is mutable' do
    lambda{ Chromosome.new.mutate(0.7) }.should_not raise_error
  end

  it 'is crossable' do
    g1 = Chromosome.new(:genes => %w(1 + 2 + 3).map{|r| Gene.new r})
    g2 = Chromosome.new(:genes => %w(4 + 5 + 6).map{|r| Gene.new r})
    lambda{ g1.crossover(g2, 1, 1) }.should_not raise_error
    g1.expression.should == '1+5+6'
    g2.expression.should == '4+2+3'
  end

  it 'fitness score can be assigned thats inversely proportional to the difference between the solution and the value a decoded chromosome represents' do
    Chromosome.new(:genes => %w(5 * 8 + 2).map{|r| Gene.new r}).fitness(42).should == 0
    Chromosome.new(:genes => %w(3 * 7).map{|r| Gene.new r}).fitness(42).should == 1.to_f/(42-21)
  end
end

