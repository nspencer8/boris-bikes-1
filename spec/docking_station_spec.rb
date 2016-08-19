require 'docking_station'
require_relative './support/bike_container'

describe DockingStation do
  let(:bike) { double(:bike) }

  before do
    allow(bike).to receive(:working?).and_return(true)
  end

  describe '#release_bike' do
    it 'should release a bike if avaliable' do
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
      expect(bike).to be_working
    end

    it 'should raise an error if no bikes' do
      expect { subject.release_bike }.to raise_error('No bikes available!')
    end

    it 'should only releases working bikes' do
      subject.dock(bike)
      expect(subject.release_bike).to be_working
      allow(bike).to receive(:working?).and_return(false)
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error 'No bikes available!'

      allow(bike).to receive(:working?).and_return(true)
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end
  end

  describe '#dock' do
    it 'should dock working bikes in working bike store' do
      subject.dock(bike)
      expect(subject.instance_variable_get(:@broken_bikes)).to eq([])
      expect(subject.instance_variable_get(:@working_bikes)).to eq([bike])
    end

    it 'should dock broken bikes in broken bike store' do
      allow(bike).to receive(:working?).and_return(false)
      subject.dock(bike)
      expect(subject.instance_variable_get(:@broken_bikes)).to eq([bike])
      expect(subject.instance_variable_get(:@working_bikes)).to eq([])
    end

    it 'should raise an error when full' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(bike) }
      expect { subject.dock(bike) }.to raise_error 'Docking station full'
    end
  end

  describe 'initialization' do
    it 'should have a default capacity' do
      expect(subject.instance_variable_get(:@capacity)).to eq DockingStation::DEFAULT_CAPACITY
    end

    it 'can have a custom capacity' do
      dock1 = DockingStation.new(30)
      expect(dock1.instance_variable_get(:@capacity)).to eq 30
    end
  end

  describe 'behaves like a bike container - with custom collect method' do
    it_behaves_like 'a bike container'

    it 'will not collect when over capacity' do
      20.times { subject.dock(bike) }
      expect { subject.collect([bike], :working) }.to raise_error 'No more space'
    end
  end
end
