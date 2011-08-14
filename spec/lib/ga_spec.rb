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

  it 'selection should exclude the selected element from population' do
    ga = GA.new(:target => 42)
    chromosome1 = ga.selection
    chromosome2 = ga.selection
    chromosome2.should_not == chromosome1
  end

  context 'simulation' do
    it 'return right expression for 10' do
      ga = GA.new(:target => 10, :chromosome_length => 7, :mutation_rate => 0.001, :crossover_rate => 0.1, :length => 2)
      ga.run
      if chromosome = ga.fittest
        chromosome.value.should == 10
      end
      puts "\ntarget: 10 \n#{ga.print}\n"
    end

    it 'return right expression for 42' do
      ga = GA.new(:target => 42, :chromosome_length => 10, :length => 10)
      ga.run
      if chromosome = ga.fittest
        chromosome.value.should == 42
      end
      puts "\ntarget: 42 \n#{ga.print}\n"
    end

    it 'return right expression for 1000' do
      ga = GA.new(:target => 1000)
      ga.run
      if chromosome = ga.fittest
        chromosome.value.should == 1000
      end
      puts "\ntarget: 1000 \n#{ga.print}\n"
    end
  end
end

