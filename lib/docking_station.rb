require_relative 'bike'

class DockingStation

  def release_bike
    fail 'no bikes available!' unless @bike
    @bike
  end

  def dock(bike)
    fail "this dock is full" unless  @bike == nil
    @bike = bike
end

  attr_reader :bike

end
