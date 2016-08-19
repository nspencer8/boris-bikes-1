require_relative 'bike'

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

private

  def full?
    @working_bikes.count + @broken_bikes.count >= @capacity
  end

  def empty?
    @working_bikes.empty?
  end
end
