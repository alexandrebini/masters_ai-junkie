class GA
  attr_reader :target, :population, :length, :generations
  attr_reader :mutation_rate, :crossover_rate, :max_generations

  def initialize(args)
    raise "Please give the target number. Ex: GA.new(:target => 42)" unless args[:target]
    options = { :length => 40, :mutation_rate => 0.001, :crossover_rate => 0.7, :max_generations => 10000, :chromosome_length => 30 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @generations = 0
    @population = Array.new(options[:length]){ Chromosome.new(:length => options[:chromosome_length]) }
  end

  def fittest
    population.find{ |chromosome| chromosome.fitness(target) == 0 }
  end

  def population_by_fitness
    population.sort{ |x,y| x.fitness(target) <=> y.fitness(target) }.reverse
  end

  def selection(current_population=@population)
    total_fitness = current_population.inject(0) { |sum,x| sum+x.fitness(target) }
    slice = rand(1000)/1000.to_f * total_fitness
    fitness = 0

    for chromosome in current_population
      fitness += chromosome.fitness(target)
      return current_population.delete(chromosome) if fitness >= slice
    end
    current_population.delete current_population.first
  end

  def to_s
    "Generations: #{generations}\n".tap do |output|
      if chromosome = fittest
        output << "Solution: #{chromosome.expression}"
      else
        output << "No solution found. Top five solutions: "
        output << population_by_fitness[0..4].map{ |chromosome| chromosome.expression }.join("    ")
      end
    end
  end

  def run
    while @generations < max_generations
      next_population = []

      current_population = @population.clone

      (@population.size/2).times do
        chromosome1 = selection(current_population)
        chromosome2 = selection(current_population)

        #output = "before: #{chromosome1.expression} (#{chromosome1.value})"

        # crossover
        chromosome1.crossover chromosome2, crossover_rate

        # mutations
        chromosome1.mutate mutation_rate
        chromosome2.mutate mutation_rate

        #puts output + "\nafter: #{chromosome1.expression} (#{chromosome1.value})\n\n"

        next_population.push(chromosome1, chromosome2)
      end

      # replace the population
      @population = next_population

      # increase population counter
      @generations += 1

      break if fittest
    end
  end

end

