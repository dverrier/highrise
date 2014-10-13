require 'spec_helper'

describe Highrise::Company do
  subject { Highrise::Company.new(:id => 1) }
  
  it { is_expected.to be_a_kind_of Highrise::Base }
  it_should_behave_like "a paginated class"
  it_should_behave_like "a taggable class"
  it_should_behave_like "a searchable class"

  it "#people" do
    expect(Highrise::Person).to receive(:find_all_across_pages).with(:from=>"/companies/1/people.xml").and_return("people")
    expect(subject.people).to eq("people")
  end
  
  it { expect(subject.label).to eq('Party') }
end
