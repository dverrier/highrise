require 'spec_helper'

describe Highrise::Account do
  it { is_expected.to be_a_kind_of Highrise::Base }
  
  it ".me" do
    expect(Highrise::Account).to receive(:find).with(:one, {:from => "/account.xml"}).and_return(subject)
    expect(Highrise::Account.me).to eq(subject)
  end
end
