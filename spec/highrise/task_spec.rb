require 'spec_helper'

describe Highrise::Task do
  it { is_expected.to be_a_kind_of Highrise::Base }
  
  it "#complete!" do
    expect(subject).to receive(:load_attributes_from_response).with("post")
    expect(subject).to receive(:post).with(:complete).and_return("post")
    subject.complete!
  end
end
