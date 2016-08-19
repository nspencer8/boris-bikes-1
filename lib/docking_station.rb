require_relative 'bike'
require_relative 'van'
require_relative 'garage'
require_relative 'bike_container'


class DockingStation
  include BikeContainer
  attr_accessor :capacity
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
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
      super(bikes, target)
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
