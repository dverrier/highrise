require 'spec_helper'

describe Highrise::TaskCategory do
  subject { Highrise::TaskCategory.new(:id => 1, :name => "Task Category") }
  
  it { is_expected.to be_a_kind_of Highrise::Base }
  
  it ".find_by_name" do
    task_category = Highrise::TaskCategory.new(:id => 2, :name => "Another Task Category")
    expect(Highrise::TaskCategory).to receive(:find).with(:all).and_return([task_category, subject])
    expect(Highrise::TaskCategory.find_by_name("Task Category")).to eq(subject)
  end
end
