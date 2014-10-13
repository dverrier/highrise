require 'spec_helper'

describe Highrise::Subject do
  subject { Highrise::Subject.new(:id => 1) }

  it { is_expected.to be_a_kind_of Highrise::Base }

  it "#notes" do
    expect(Highrise::Note).to receive(:find_all_across_pages).with({:from=>"/subjects/1/notes.xml"}).and_return("notes")
    expect(subject.notes).to eq("notes")
  end

  it "#add_note" do
    expect(Highrise::Note).to receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Subject'}).and_return(double('note'))
    subject.add_note :body=>'body'
  end
  
  it "#add_task" do
    expect(Highrise::Task).to receive(:create).with({:body=>"body", :subject_id=>1, :subject_type=>'Subject'}).and_return(double('task'))
    subject.add_task :body=>'body'
  end

  it "#emails" do
    expect(Highrise::Email).to receive(:find_all_across_pages).with({:from=>"/subjects/1/emails.xml"}).and_return("emails")
    expect(subject.emails).to eq("emails")
  end

  it "#upcoming_tasks" do
    expect(Highrise::Task).to receive(:find).with(:all, {:from=>"/subjects/1/tasks.xml"}).and_return("tasks")
    expect(subject.upcoming_tasks).to eq("tasks")
  end
  
  it { expect(subject.label).to eq("Subject") }
end