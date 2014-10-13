shared_examples_for "a taggable class" do
  before(:each) do
    (@tags = []).tap do 
      @tags << {'id' => "414578", 'name' => "cliente"}
      @tags << {'id' => "414580", 'name' => "ged"}
      @tags << {'id' => "414579", 'name' => "iepc"}
    end
  end

  it { expect(subject.class.included_modules).to include(Highrise::Taggable) }

  it "#tags" do
    expect(subject).to receive(:get).with(:tags).and_return(@tags)
    expect(subject.tags).to eq(@tags)
  end
  
  it "#tag!(tag_name)" do
    expect(subject).to receive(:post).with(:tags, :name => "client" ).and_return(true)
    expect(subject.tag!("client")).to be_truthy
  end
  
  it "#untag!(tag_name)" do
    expect(subject).to receive(:get).with(:tags).and_return(@tags)
    expect(subject).to receive(:delete).with("tags/414578").and_return(true)
    expect(subject.untag!("cliente")).to be_truthy
  end
end