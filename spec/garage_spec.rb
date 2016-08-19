require 'garage'
require_relative './support/bike_container'

describe Garage do
  it_behaves_like 'a bike container'

  it 'fixes bikes' do
    bike2 = double(:bike, working?: false)
    subject.collect([bike2], :broken)
    expect(bike2).to receive(:fix)
    subject.fix_bikes
    expect(subject.instance_variable_get(:@broken_bikes)).to eq([])
    expect(subject.instance_variable_get(:@working_bikes)).to eq([bike2])
  end
end
