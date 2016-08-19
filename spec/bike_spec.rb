require 'bike'

describe Bike do
  it 'Working bikes can be reported broken and fixed' do
    expect(subject).to be_working
    subject.report_broken
    expect(subject).to_not be_working
    subject.fix
    expect(subject).to be_working
  end
end
