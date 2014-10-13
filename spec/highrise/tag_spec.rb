require 'spec_helper'

describe Highrise::Tag do
  subject { Highrise::Tag.new(:id => 1, :name => "Name") }
  
  it { is_expected.to be_a_kind_of Highrise::Base }

  it "supports equality" do
    tag = Highrise::Tag.new(:id => 1, :name => "Name")
    expect(subject).to eq(tag)
  end
  
  it ".find_by_name" do
    tag = Highrise::Tag.new(:id => 2, :name => "Next")
    expect(Highrise::Tag).to receive(:find).with(:all).and_return([tag, subject])
    expect(Highrise::Tag.find_by_name("Name")).to eq(subject)
  end
end
