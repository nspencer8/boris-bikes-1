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
      expect(subject.dock(bike)).to eq [bike]
    end

    it "should put an error that dock is full if more than 20 bikes are docked" do
      20.times do
        subject.dock(Bike.new)
      end
      expect {subject.dock Bike.new}.to raise_error("this dock is full")
    end
  end

  it { is_expected.to respond_to(:bikes)}

  it "the dock confirms it has a bike" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.bikes).to eq [bike]
  end

end
