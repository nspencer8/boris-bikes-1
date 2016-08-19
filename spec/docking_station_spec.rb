require 'docking_station'
require_relative './support/bike_container'

describe DockingStation do
  let(:bike) { double :bike }
  before do
    allow(bike).to receive(:working?).and_return(true)
  end

  it_behaves_like "a bike container"

  describe '#release_bike' do
    it 'releases a bike' do
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
      expect(bike).to be_working
    end

    it 'should raise an error if no bikes' do
      expect {subject.release_bike}.to raise_error('no bikes available!')
    end

    it 'Only releases working bikes' do
      subject.dock(bike)
      expect(subject.release_bike).to be_working
      allow(bike).to receive(:working?).and_return(false)
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error 'no bikes available!'
    end
  end

  describe '#dock' do
    it "docks the bike" do
      expect(subject.dock(bike)).to eq [bike]
    end

    it 'raises an error when full' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(bike) }
      expect { subject.dock(bike) }.to raise_error 'Docking station full'
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

  describe 'capcity checks on collect' do
    it 'will not collect when over capacity' do
      bike1 = double(:bike, :working? => true)
      20.times { subject.dock(bike1)}
      expect { subject.collect([bike1], :working) }.to raise_error 'No more space'
    end
  end
end
