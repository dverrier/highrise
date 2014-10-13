shared_examples_for "a searchable class" do
  it { expect(subject.class.included_modules).to include(Highrise::Searchable) }

  it ".search" do
    find_args = {:from => "/#{subject.class.collection_name}/search.xml", :params => {"criteria[email]" => "john.doe@example.com", "criteria[zip]" => "90210"}}
    if subject.class.respond_to?(:find_all_across_pages)
      expect(subject.class).to receive(:find_all_across_pages).with(find_args)
    else
      expect(subject.class).to receive(:find).with(:all, find_args)
    end
    subject.class.search(:email => "john.doe@example.com", :zip => "90210")
  end
end
