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

  end

  it 'releases working bikes' do
    new_bike = Bike.new
    expect(new_bike).to be_working
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  describe '#dock' do
    it "docks the bike" do
      bike = Bike.new
      expect(subject.dock(bike)).to eq bike
    end

    it "should put an error if dock is full" do
      bike = Bike.new
      subject.dock(bike)
      bike2 = Bike.new
      expect {subject.dock(bike2)}.to raise_error("this dock is full")
    end
  end

  it { is_expected.to respond_to(:bike)}

  it "the dock confirms it has a bike" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.bike).to eq bike
  end

end
