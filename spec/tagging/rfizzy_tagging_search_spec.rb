require "spec_helper"

describe Rfizzy, "tagging search_index" do
  let(:namespace) { TaggingFactory.instance.namespace }
  let(:article) { TaggingFactory.instance.article }
  let(:document_key_name) { TaggingFactory.instance.document_key_name }
  let(:document_id) { TaggingFactory.instance.document_id }
  let(:tag_key_name) {TaggingFactory.instance.tag_key_name}
  let(:tag_list) { TaggingFactory.instance.tag_list }
  let(:tag_size) { TaggingFactory.instance.tag_size }
  let(:tags) { tag_list }
  let(:tag_parameters) do 
                          {:association => article[:association],
                           :attribute_namespace => article[:attribute_namespace],
                           :search => tags} 
                         end
    
    let(:tag_keys) do 
      search_keys_var = tags.map do |word|
        "#{namespace}:word:#{article[:association]}:#{article[:attribute_namespace]}:#{word}"
      end
    end

    let(:non_tag_keys) do 
      search_keys_var = "does not exist".split(" ").map do |word|
        "#{namespace}:word:#{article[:association]}:#{article[:attribute_namespace]}:#{word}"
      end
    end

    context "searching with multiple tags" do
      before(:each) do
        @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
        @search.create_index(article)
      end


      context "should find something" do
        it "should return the document associated" do
          @search.should_receive(:search_keys).with(tag_parameters).and_return(tag_keys)
          found_document_id = @search.search_index tag_parameters
          found_document_id.should include(document_id)
        end
      end
      
      context "should find nothing" do
        it "should not return the document associated" do
          @search.should_receive(:search_keys).with(tag_parameters).and_return(non_tag_keys)
          found_document_id = @search.search_index tag_parameters
          found_document_id.should_not include(document_id)
          found_document_id.should be_empty
        end
        
      end

    end
  end
