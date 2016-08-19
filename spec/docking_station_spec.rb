require 'docking_station'

describe DockingStation do

  describe '#release_bike' do
    it 'releases a bike' do
      bike = double(:bike)
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
      expect(bike).to be_working
    end

    it 'should raise an error if no bikes' do
      expect {subject.release_bike}.to raise_error('no bikes available!')
    end

    it 'Only releases working bikes' do
      bike = double(:bike)
      subject.dock(bike)
      expect(subject.release_bike).to be_working
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error 'no bikes available!'
    end
  end

  describe '#dock' do
    it "docks the bike" do
      bike = double(:bike)
      expect(subject.dock(bike)).to eq [bike]
    end

    it 'raises an error when full' do
      DockingStation::DEFAULT_CAPACITY.times {subject.dock double(:bike)}
      expect {subject.dock double(:bike)}.to raise_error 'Docking station full'
    end
  end

  describe 'initialization' do
    it 'has a default capacity' do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end

    it 'has a custom capacity' do
      expect(DockingStation.new(30).capacity).to eq 30
    end
  end
end
