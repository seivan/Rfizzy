require "spec_helper"

describe Rfizzy, "search create_index" do
  let(:namespace) { SearchFactory.instance.namespace }
  let(:tweet) { SearchFactory.instance.tweet }
  let(:document_key_name) { SearchFactory.instance.document_key_name }
  
  let(:word_key_name) {SearchFactory.instance.word_key_name}
  let(:word_list) { SearchFactory.instance.word_list }
  let(:word_size) { SearchFactory.instance.word_size }

  before(:each) do
    @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
    @search.create_index(tweet)
  end
  
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
        R.exists("#{word_key_name}#{word}").should be_true
      end
    end
    it "should refer to the document_id" do
      word_list.each do |word|
        R.sismember("#{word_key_name}#{word}", tweet[:document_id])
      end
    end
  end
  end
end  
