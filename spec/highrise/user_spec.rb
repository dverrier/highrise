require 'spec_helper'

describe Highrise::User do
  it { is_expected.to be_a_kind_of Highrise::Base }
  
  it ".me" do
    expect(Highrise::User).to receive(:find).with(:one, {:from => "/me.xml"}).and_return(subject)
    expect(Highrise::User.me).to eq(subject)
  end
  
  it "#join" do
    group_mock = double("group")
    expect(group_mock).to receive(:id).and_return(2)
    expect(subject).to receive(:id).and_return(1)
    expect(Highrise::Membership).to receive(:create).with({:user_id=>1, :group_id=>2})
    subject.join(group_mock)
  end
end
