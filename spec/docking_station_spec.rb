require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }
  it { expect(DockingStation.new.release_bike).to be_an_instance_of(Bike) }
  it { expect(DockingStation.new.release_bike).to be_working }
end
