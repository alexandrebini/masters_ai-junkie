class GA
  attr_reader :target, :population, :length, :generations
  attr_reader :mutation_rate, :crossover_rate, :max_generations

  def initialize(args)
    raise "Please give the target number. Ex: GA.new(:target => 42)" unless args[:target]
    options = { :length => 40, :mutation_rate => 001, :crossover_rate => 0.7, :max_generations => 400 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @generations = 0
    @population = Array.new(options[:length]){ Chromosome.new }
  end

  def fittest
    population.find{ |chromosome| chromosome.fitness(target) == 0 }
  end

  def termination
    if chromosome = fittest
      puts "Solution: #{chromosome.expression}"
    else
      puts "No solution found"
    end
    puts "Generations: #{generations}"
  end

  def run
    while generations < max_generations
      if fittest
        termination
        break
      end

    end
  end

end

