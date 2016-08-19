require_relative 'bike'
require_relative 'van'
require_relative 'garage'
require_relative 'bike_container'

# Knows how to dock and release objects
class DockingStation
  include BikeContainer
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    super()
  end

  def release_bike
    raise 'No bikes available!' if empty?
    @working_bikes.pop
  end

  def dock(bike_object)
    raise 'Docking station full' if full?
    if bike_object.working?
      @working_bikes << bike_object
    else
      @broken_bikes << bike_object
    end
  end

  def collect(bikes, target)
    raise 'No more space' if bikes.length >= free_space
    super(bikes, target)
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
