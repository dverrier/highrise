# encoding: utf-8
require 'spec_helper'

describe Highrise::Person do
  subject { Highrise::Person.new(:id => 1) }
  
  it { is_expected.to be_a_kind_of Highrise::Subject }

  it_should_behave_like "a paginated class"
  it_should_behave_like "a taggable class"
  it_should_behave_like "a searchable class", Highrise::Person, "people"

  describe "#company" do
    it "returns nil when it doesn't have a company" do
      expect(subject).to receive(:company_id).and_return(nil)
      expect(subject.company).to be_nil
    end

    it "delegate to Highrise::Company when have company_id" do
      expect(subject).to receive(:company_id).at_least(2).times.and_return(1)
      expect(Highrise::Company).to receive(:find).with(1).and_return("company")
      expect(subject.company).to eq("company")
    end
  end
  
  it "#name" do
    expect(subject).to receive(:first_name).and_return("Marcos")
    expect(subject).to receive(:last_name).and_return("Tapajós     ")
    expect(subject.name).to eq("Marcos Tapajós")
  end
  
  it { expect(subject.label).to eq('Party') }
end
