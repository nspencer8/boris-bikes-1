require_relative 'bike'

class DockingStation

  DEFAULT_CAPACITY = 20

  def initialize
    @bikes = []
  end

  def release_bike
    fail 'no bikes available!' if empty?
    @bikes.pop
  end

  def dock(bike)
    fail "this dock is full" if full?
    @bikes << bike
  end

  attr_reader :bikes

private

  def full?
    @bikes.count >= DEFAULT_CAPACITY
  end

  def empty?
    @bikes.empty?
  end


end
