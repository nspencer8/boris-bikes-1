require 'docking_station'

describe DockingStation do
  let(:bike) { double :bike }
  before do
  allow(bike).to receive(:working?).and_return(true)
end

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

  it 'collects working / broken bikes' do
    bike1 = double(:bike, :working? => true)
    subject.collect([bike1], :working)
    expect(subject.instance_variable_get(:@working_bikes)).to eq([bike1])

    bike2 = double(:bike, :working? => false)
    subject.collect([bike2],:broken)
    expect(subject.instance_variable_get(:@broken_bikes)).to eq([bike2])

    expect{subject.collect([bike1],:wrongTarget)}.to raise_error 'Check Collect Target'

    18.times { subject.dock(bike1)}
    expect { subject.collect([bike1], :working) }.to raise_error 'No more space'


  end

  it 'gives bikes to destination' do
    bike1 = double(:bike, :working? => true)
    van = double(:van, :collect => true)
    subject.collect([bike1], :working)

    expect(van).to receive(:collect).with([bike1],:working)
    subject.give(van, :working)
    expect(subject.instance_variable_get(:@working_bikes)).to eq([])


    bike2 = double(:bike, :working? => false)
    subject.collect([bike2], :broken)

    expect(van).to receive(:collect).with([bike2],:broken)
    subject.give(van, :broken)
    expect(subject.instance_variable_get(:@broken_bikes)).to eq([])

    expect{subject.give(van, :wrongTarget)}.to raise_error 'Check Destination'
  end
end
