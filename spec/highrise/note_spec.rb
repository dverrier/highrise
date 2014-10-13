require 'spec_helper'

describe Highrise::Note do
  subject { Highrise::Note.new(:id => 1) }
  
  it { is_expected.to be_a_kind_of Highrise::Base }

  it_should_behave_like "a paginated class"
  
  it "#comments" do
    expect(Highrise::Comment).to receive(:find).with(:all, {:from=>"/notes/1/comments.xml"}).and_return("comments")
    expect(subject.comments).to eq("comments")
  end
end
