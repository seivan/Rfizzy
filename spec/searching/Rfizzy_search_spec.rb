require "spec_helper"

describe Rfizzy, "search" do
  let(:namespace) { SearchFactory.instance.namespace }
  let(:tweet) { SearchFactory.instance.tweet }
  let(:document_key_name) { SearchFactory.instance.document_key_name }
  let(:document_id) { SearchFactory.instance.document_id }
  let(:word_key_name) {SearchFactory.instance.word_key_name}
  let(:word_list) { SearchFactory.instance.word_list }
  let(:word_size) { SearchFactory.instance.word_size }
  let(:search_words) { word_list.join(" ") }
  let(:search_parameters) do 
                          {:association => tweet[:association],
                           :attribute_namespace => tweet[:attribute_namespace],
                           :search_text => search_words} 
                         end
    
    let(:search_keys) do 
      search_keys_var = search_words.split(" ").map do |word|
        "#{namespace}:word:#{tweet[:association]}:#{tweet[:attribute_namespace]}:#{word}"
      end
    end

    let(:non_search_keys) do 
      search_keys_var = "shit balls".split(" ").map do |word|
        "#{namespace}:word:#{tweet[:association]}:#{tweet[:attribute_namespace]}:#{word}"
      end
    end

    context "searching with multiple words" do
      before(:each) do
        @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
        @search.create_index(tweet)
      end


      context "should find something" do
        it "should return the document associated" do
          @search.should_receive(:search_keys).with(search_parameters).and_return(search_keys)
          found_document_id = @search.search_index search_parameters
          found_document_id.should include(document_id)
        end
      end
      context "should find nothing" do
        it "should return the document associated" do
          @search.should_receive(:search_keys).with(search_parameters).and_return(non_search_keys)
          found_document_id = @search.search_index search_parameters
          found_document_id.should_not include(document_id)
          found_document_id.should be_empty
        end
        
      end

    end
  end
