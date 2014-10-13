require 'spec_helper'

describe Highrise::Party do
  it { is_expected.to be_a_kind_of Highrise::Base }

  it ".recently_viewed" do
    expect(Highrise::Party).to receive(:find).with(:all, {:from => '/parties/recently_viewed.xml'})
    Highrise::Party.recently_viewed
  end
  
  it ".deletions_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    expect(Highrise::Party).to receive(:find).with(:all, {:from => '/parties/deletions.xml', :params=>{:since=>"20090114174311"}}).and_return("result")
    expect(Highrise::Party.deletions_since(time)).to eq("result")
  end
end