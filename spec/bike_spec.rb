require "bike"

describe Bike do

  it 'Working bikes can be reported broken' do
    expect(subject).to be_working
    subject.report_broken
    expect(subject).to_not be_working
  end

  it 'Can be fixed' do
    subject.report_broken
    subject.fix
    expect(subject).to be_working
  end
end
