require_relative 'bike'
require_relative 'van'
require_relative 'garage'

class DockingStation

  attr_accessor :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @capacity = capacity
    @working_bikes = []
    @broken_bikes = []
  end

  def release_bike
    fail 'no bikes available!' if empty?
    @working_bikes.pop
  end

  def dock(bike_object)
    fail "Docking station full" if full?
    if bike_object.working?
       @working_bikes << bike_object
  else
    @broken_bikes << bike_object
  end
end

def collect(bikes, target)
  if bikes.length >= free_space
    raise 'No more space'
  else
    if target == :working
      @working_bikes += bikes
    elsif target == :broken
      @broken_bikes += bikes
    else
      raise 'Check Collect Target'
    end
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


private

  def full?
    @working_bikes.count + @broken_bikes.count >= @capacity
  end

  def empty?
    @working_bikes.empty?
  end

  def free_space
    @capacity - (@working_bikes.count + @broken_bikes.count)
  end
end
