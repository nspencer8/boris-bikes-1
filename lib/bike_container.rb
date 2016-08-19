# Knows how to transfer objects between containers
module BikeContainer
  def collect(bikes, target)
    if target == :working
      @working_bikes += bikes
    elsif target == :broken
      @broken_bikes += bikes
    else
      raise 'Check Collect Target'
    end
  end

  def give(destination, target)
    if target == :working
      destination.collect(@working_bikes, :working)
      @working_bikes = []
    elsif target == :broken
      destination.collect(@broken_bikes, :broken)
      @broken_bikes = []
    else
      raise 'Check Destination'
    end
  end
end
