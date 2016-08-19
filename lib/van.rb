require_relative 'bike_container'

class Van
  include BikeContainer
  def initialize
    @working_bikes = []
    @broken_bikes = []
  end
end
