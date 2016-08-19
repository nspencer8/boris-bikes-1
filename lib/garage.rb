require_relative 'bike_container'

class Garage
include BikeContainer
  def initialize
    @working_bikes = []
    @broken_bikes = []
  end

  def fix_bikes
    @broken_bikes.each {|x| x.fix}
    @working_bikes += @broken_bikes
    @broken_bikes = []
  end
end
