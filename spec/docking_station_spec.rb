require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'releases working bikes' do
    new_bike = DockingStation.new.release_bike
    expect(new_bike).to be_working
  end
end
