class GA
  attr_reader :target, :population, :length, :generations
  attr_reader :mutation_rate, :crossover_rate, :max_generations

  def initialize(args)
    raise "Please give the target number. Ex: GA.new(:target => 42)" unless args[:target]
    options = { :length => 40, :mutation_rate => 0.001, :crossover_rate => 0.7, :max_generations => 500 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @generations = 0
    @population = Array.new(options[:length]){ Chromosome.new }
  end

  def fittest
    population.find{ |chromosome| chromosome.fitness(target) == 0 }
  end

  def population_by_fitness
    population.sort{ |x,y| x.fitness(target) <=> y.fitness(target) }.reverse
  end

  def selection
    total_fitness = population.inject(0) { |sum,x| sum+x.fitness(target) }
    slice = rand(1000)/1000.to_f * total_fitness
    fitness = 0
    for chromosome in population
      fitness += chromosome.fitness(target)
      return chromosome if fitness >= slice
    end
    nil
  end

  def finish
    if chromosome = fittest
      puts "Solution: #{chromosome.expression}"
    else
      puts "No solution found. Here the top five solutions"
      population_by_fitness[0..4].each{ |chromosome| puts "\t#{chromosome.expression}" }
    end
    puts "Generations: #{generations}"
  end

  def run
    while @generations < max_generations
      puts "#{@generations}/#{max_generations}"
      next_population = []

      (population.size/2).times do
        chromosome1 = selection
        chromosome2 = selection

        # crossover
        chromosome1.crossover chromosome2, crossover_rate

        # mutations
        chromosome1.mutate mutation_rate
        chromosome2.mutate mutation_rate

        next_population.push(chromosome1, chromosome2)
      end

      # replace the population
      population = next_population

      # increase population counter
      @generations += 1

      break if fittest
    end
    finish
  end

end

