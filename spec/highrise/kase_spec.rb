require 'spec_helper'

describe Highrise::Kase do
  it { is_expected.to be_a_kind_of Highrise::Subject }

  it_should_behave_like "a paginated class"

  it "#close!" do
    mocked_now = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    expect(Time).to receive(:now).and_return(mocked_now)
    expect(subject).to receive(:update_attribute).with(:closed_at, mocked_now.utc)
    subject.close!
  end

  it "#open!" do
    expect(subject).to receive(:update_attribute).with(:closed_at, nil)
    subject.open!
  end

  it ".all_open_across_pages" do
    expect(subject.class).to receive(:find).with(:all,{:from=>"/kases/open.xml",:params=>{:n=>0}}).and_return(["things"])
    expect(subject.class).to receive(:find).with(:all,{:from=>"/kases/open.xml",:params=>{:n=>1}}).and_return([])
    expect(subject.class.all_open_across_pages).to eq(["things"])
  end

  it ".all_closed_across_pages" do
    expect(subject.class).to receive(:find).with(:all,{:from=>"/kases/closed.xml",:params=>{:n=>0}}).and_return(["things"])
    expect(subject.class).to receive(:find).with(:all,{:from=>"/kases/closed.xml",:params=>{:n=>1}}).and_return([])
    expect(subject.class.all_closed_across_pages).to eq(["things"])
  end
end
