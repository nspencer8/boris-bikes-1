require_relative 'bike_container'

# Knows how to move objects between classes
class Van
  include BikeContainer
  def initialize
    super()
  end
end
