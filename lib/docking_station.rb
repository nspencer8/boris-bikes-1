require_relative 'bike'

class DockingStation

  def release_bike
    if @bike == nil
      raise 'no bikes available!'
    else
      @bike
    end
  end

  def dock(bike)
    @bike = bike
  end

  attr_reader :bike

end
