require "bike"

describe Bike do

  it 'Working bikes can be reported broken' do
    expect(subject).to be_working
    subject.report_broken
    expect(subject).to be_broken
  end
end
