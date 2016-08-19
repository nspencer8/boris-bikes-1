require 'docking_station'

describe DockingStation do


  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'should raise an error if no bikes' do
      expect {subject.release_bike}.to raise_error('no bikes available!')
      # using {} to evaluate a block of code as opposed to () which allows us to evaluate a value
    end

    it 'Only releases working bikes' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to be_working
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error 'no bikes available!'
    end

  end

  describe '#dock' do
    it "docks the bike" do
      bike = Bike.new
      expect(subject.dock(bike)).to eq [bike]
    end

    it 'raises an error when full' do
      subject.capacity.times {subject.dock Bike.new}
      expect {subject.dock Bike.new}.to raise_error 'Docking station full'
    end
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

    describe 'initialization' do
      it 'has a custom capacity of 30' do
    expect(DockingStation.new(30).capacity).to eq 30
    end
  end
end
