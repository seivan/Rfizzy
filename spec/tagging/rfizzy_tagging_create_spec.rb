require "spec_helper"

describe Rfizzy, "tagging create" do
  let(:namespace) { TaggingFactory.instance.namespace }
  let(:article) { TaggingFactory.instance.article }
  let(:document_key_name) { TaggingFactory.instance.document_key_name }
  
  let(:word_key_name) {TaggingFactory.instance.word_key_name}
  let(:tag_list) { TaggingFactory.instance.tag_list }
  let(:tag_size) { TaggingFactory.instance.tag_size }
    
  before(:each) do
    @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
    @search.create_index(article)
  end
  
context "create an index with" do      
  context "a document that" do
    it "should exist " do
      R.exists(document_key_name).should be_true
    end
    it "should be of the type set" do
      R.type(document_key_name).should == "set"
    end
    it "should contain tags" do  
      R.smembers(document_key_name).should have(tag_size).things
    end             
  end

  context "a set for each tag that" do
    it "should exist" do
      tag_list.each do |word|
        R.exists("#{word_key_name}#{word}").should be_true
      end
    end
    it "should refer to the document_id" do
      tag_list.each do |word|
        R.sismember("#{word_key_name}#{word}", article[:document_id])
      end
    end
  end
  end
end  
