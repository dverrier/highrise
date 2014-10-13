require 'spec_helper'

describe Highrise::Email do
  it { is_expected.to be_a_kind_of Highrise::Base }

  it_should_behave_like "a paginated class"
  
  it "#comments" do
    expect(subject).to receive(:id).and_return(1)
    expect(Highrise::Comment).to receive(:find).with(:all, {:from=>"/emails/1/comments.xml"}).and_return("comments")
    expect(subject.comments).to eq("comments")
  end
end
