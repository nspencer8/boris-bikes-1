require_relative 'bike_container'

# Knows how to fix objects
class Garage
  include BikeContainer
  def initialize
    super()
  end

  def fix_bikes
    @broken_bikes.each(&:fix)
    @working_bikes += @broken_bikes
    @broken_bikes = []
  end
end
