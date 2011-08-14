class Chromosome

  attr_reader :genes

  def initialize(args={})
    options = { :length => 4 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @genes = Array.new(options[:length]){ Gene.random } if @genes.nil?
  end

  def expression
    genes = valid_genes.map(&:value)
    return genes.join if genes.size > 0
    nil
  end

  def value
    eval(expression)
    rescue ZeroDivisionError
      0
  end

  def valid_genes
    Array.new.tap do |valid_genes|
      genes.each_with_index do |gene, index|
        next if gene.value.nil?

        if gene.is_number?
          next unless valid_genes.size == 0 || valid_genes.last.is_operator?
          valid_genes << gene

        elsif gene.is_operator?
          next if valid_genes.size == 0 || valid_genes.last.is_operator? || genes.last == gene || !genes[index+1].is_number?
          valid_genes << gene
        end

      end
    end
  end

  def fitness(target)
    return nil if target.nil?
    return 0 if  target == value
    return 1.to_f / (target - value)
  end

  def mutate(mutation_rate)
    for gene in genes
      next if rand(1000)/1000.to_f <= mutation_rate
      gene.swap! rand(4)
    end
  end

  def crossover(chromosome, crossover_rate, position=nil)
    return if rand(100)/100.to_f > crossover_rate
    position = rand(genes.size - 1) if position.nil?
    position.upto(genes.size - 1) do |index|
      tmp_gene = genes[index]
      genes[index] = chromosome.genes[index]
      chromosome.genes[index] = tmp_gene
    end
  end

end

