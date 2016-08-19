require 'van'

describe Van do

  it 'collects working / broken bikes' do
    bike1 = double(:bike, :working? => true)
    subject.collect([bike1], :working)
    expect(subject.instance_variable_get(:@working_bikes)).to eq([bike1])

    bike2 = double(:bike, :working? => false)
    subject.collect([bike2],:broken)
    expect(subject.instance_variable_get(:@broken_bikes)).to eq([bike2])

    expect{subject.collect([bike1],:wrongTarget)}.to raise_error 'Check Collect Target'
  end

  it 'gives bikes to destination' do
    bike1 = double(:bike, :working? => true)
    station = double(:DockingStation, :collect => true)
    subject.collect([bike1], :working)

    expect(station).to receive(:collect).with([bike1],:working)
    subject.give(station, :working)
    expect(subject.instance_variable_get(:@working_bikes)).to eq([])


    bike2 = double(:bike, :working? => false)
    garage = double(:Garage, :collect => true)
    subject.collect([bike2], :broken)

    expect(garage).to receive(:collect).with([bike2],:broken)
    subject.give(garage, :broken)
    expect(subject.instance_variable_get(:@broken_bikes)).to eq([])

    expect{subject.give(garage, :wrongTarget)}.to raise_error 'Check Destination'

  end

end
