require "spec_helper"

describe GA do
  it 'need a target' do
    lambda{ GA.new }.should raise_error
    lambda{ GA.new(:target => 42) }.should_not raise_error
  end

  it 'generate a random population' do
    ga = GA.new(:target => 42, :length => 40)
    ga.population.size.should == 40
  end

  it 'find in the current population the chromosome who matches with the target' do
    lambda{ GA.new(:target => 42).fittest }.should_not raise_error
  end

  it 'count the number of generations' do
    lambda{ GA.new(:target => 42).generations }.should_not raise_error
    GA.new(:target => 42).generations.should == 0
  end

  it 'select a member by roulete' do
    lambda{ GA.new(:target => 42).selection }.should_not raise_error
  end

  context 'simulation' do
    it 'return right expression for 42' do
      ga = GA.new(:target => 42)
      ga.run
    end
  end
end

