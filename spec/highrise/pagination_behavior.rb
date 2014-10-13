shared_examples_for "a paginated class" do
  it { expect(subject.class.included_modules).to include(Highrise::Pagination) }

  it ".find_all_across_pages" do
    expect(subject.class).to receive(:find).with(:all,{:params=>{:n=>0}}).and_return(["things"])
    expect(subject.class).to receive(:find).with(:all,{:params=>{:n=>1}}).and_return([])
    expect(subject.class.find_all_across_pages).to eq(["things"])
  end
  
  it ".find_all_across_pages with zero results" do
    expect(subject.class).to receive(:find).with(:all,{:params=>{:n=>0}}).and_return(nil)
    expect(subject.class.find_all_across_pages).to eq([])
  end

  it ".find_all_across_pages_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    expect(subject.class).to receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
    expect(subject.class.find_all_across_pages_since(time)).to eq("result")
  end
  
  it ".find_all_deletions_across_pages" do
    class TestClass2 < Highrise::Base; include Highrise::Pagination; end
    subject_type = subject.class.to_s.split('::').last
    deleted_resource_1 = subject.class.new(:id => 12, :type => subject_type)
    deleted_resource_2 = TestClass2.new(:id => 34, :type => 'TestClass2')
    deleted_resource_3 = subject.class.new(:id => 45, :type => subject_type)
    
    expect(subject.class).to receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>1}}).and_return([deleted_resource_1, deleted_resource_2, deleted_resource_3])
    expect(subject.class).to receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>2}}).and_return([])
    expect(subject.class.find_all_deletions_across_pages).to eq([deleted_resource_1, deleted_resource_3])
  end
  
  it ".find_all_deletions_across_pages with zero results" do
    expect(subject.class).to receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>1}}).and_return(nil)
    expect(subject.class.find_all_deletions_across_pages).to eq([])
  end

  it ".find_all_deletions_across_pages_since" do
    class TestClass2 < Highrise::Base; include Highrise::Pagination; end
    subject_type = subject.class.to_s.split('::').last
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    deleted_resource_1 = subject.class.new(:id => 12, :type => subject_type)
    deleted_resource_2 = TestClass2.new(:id => 34, :type => 'TestClass2')
    deleted_resource_3 = subject.class.new(:id => 45, :type => subject_type)

    expect(subject.class).to receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>1, :since=>"20090114174311"}}).and_return([deleted_resource_1, deleted_resource_2, deleted_resource_3])
    expect(subject.class).to receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>2, :since=>"20090114174311"}}).and_return([])
    expect(subject.class.find_all_deletions_across_pages_since(time)).to eq([deleted_resource_1, deleted_resource_3])
  end
end
