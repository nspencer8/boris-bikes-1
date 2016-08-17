require_relative 'bike'

class DockingStation

  def initialize
    @bikes = []
  end

  def release_bike
    fail 'no bikes available!' if @bikes.count == 0
    @bikes.pop
  end

  def dock(bike)
    fail "this dock is full" unless @bikes.count < 20
    @bikes.push(bike)
  end

  attr_reader :bikes

end
