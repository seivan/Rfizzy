require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Rfizzy do
  context "should raise error if" do
    it "initialized with no redis passed to it" do
      lambda { Rfizzy.new() }.should raise_error
    end
  end
  context "initialization with arguments" do
    subject  {Rfizzy.new(:namespace => namespace, :redis => R) }
    let(:namespace) { "FullTextSearch" }
    it { should be_an_instance_of Rfizzy }
    it { subject.namespace.should  == namespace }
  end

  context "initialization with blank namespace" do
    subject  {Rfizzy.new(:namespace => namespace, :redis => R) }
    let(:namespace) { "  " }
    it { subject.namespace.should  == "Rfizzy:" }  
  end

  context "initialization with no namespace" do
    context "with hash param for redis" do
      subject  { Rfizzy.new(:redis => R) }
      it { subject.namespace.should  == "Rfizzy:" }       
    end
    context "with just a redis object as param" do
      before(:each) do
        lambda { Rfizzy.new(R) }.should_not raise_error
      end
      subject {Rfizzy.new(R)}
      it { subject.namespace.should  == "Rfizzy:" } 
    end

  end


  describe "Usage" do
    before(:each) do
      @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
      @search.create_index(tweet)
    end
    let(:namespace) { "short" }
    let(:tweet) do {
      :attribute_namespace => :tweet,
      :document_id => "MyPost",
      :association => "MyUser",
      :text => "should create the document set with proper key names filled with words"
    }
  end
  let(:document_key_name) {"#{namespace}:document:#{tweet[:association]}:#{tweet[:attribute_namespace]}:#{tweet[:document_id]}"}
  let(:word_key_name) {"#{namespace}:word:#{tweet[:association]}:#{tweet[:attribute_namespace]}"}
  let(:word_list) { tweet[:text].split(" ").uniq }
  let(:word_size) { word_list.count }

  context "create an index with" do      

    context "a document that" do
      it "should exist " do
        R.exists(document_key_name).should be_true
      end
      it "should be of the type set" do
        R.type(document_key_name).should == "set"
      end
      it "should contain words" do  
        R.smembers(document_key_name).should have(word_size).things
      end             
    end
    
    context "a set for each word that" do
      it "should exist" do
        word_list.each do |word|
          R.exists("#{word_key_name}:#{word}").should be_true
        end
      end

      it "should refer to the document_id" do
        word_list.each do |word|
          R.sismember("#{word_key_name}:#{word}", tweet[:document_id])
        end
      end

    end


  end  
end  
end
