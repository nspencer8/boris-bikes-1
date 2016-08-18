require 'docking_station'
require 'bike'

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
      expect(subject).to be_working #FAILED TEST NEEDS FIXING
    end

  end

  it 'releases working bikes' do
    new_bike = Bike.new
    expect(new_bike).to be_working
  end


  it { is_expected.to respond_to(:dock).with(1).argument }

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
      subject {DockingStation.new}
      let(:bike) {Bike.new}
      it 'defaults capacity' do
        described_class::DEFAULT_CAPACITY.times do
          subject.dock(bike)
        end
        expect {subject.dock(bike)}.to raise_error 'Docking station full'
    end
  end
end
