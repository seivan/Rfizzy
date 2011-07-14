require "spec_helper"

describe Rfizzy, "search" do
  let(:namespace) { SearchFactory.instance.namespace }
  let(:tweet) { SearchFactory.instance.tweet }
  let(:document_key_name) { SearchFactory.instance.document_key_name }
  let(:document_id) { SearchFactory.instance.document_id }
  let(:word_key_name) {SearchFactory.instance.word_key_name}
  let(:word_list) { SearchFactory.instance.word_list }
  let(:word_size) { SearchFactory.instance.word_size }
  let(:search_word) { word_list[0] }
  let(:search_words) { word_list.join(" ") }
  let(:search_parameters) { {:association => tweet[:association],
                             :attribute_namespace => tweet[:attribute_namespace],
                             :search_text => search_word} }
  
  context "searching for a single word" do
    before(:each) do
      @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
      @search.create_index(tweet)
    end

    
    context "that exists" do
      it "should return the document associated" do
        @search.should_receive(:search_keys).with(search_parameters)
        found_document_id = @search.search_index search_parameters
        found_document_id.should == document_id
      end
    end
    
  end
end
