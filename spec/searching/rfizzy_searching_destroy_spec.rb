require "spec_helper"
describe Rfizzy, "search destroy_index" do
  let(:namespace) { SearchFactory.instance.namespace }
  let(:tweet) { SearchFactory.instance.tweet }
  let(:document_key_name) { SearchFactory.instance.document_key_name }
  let(:document_id) { SearchFactory.instance.document_id }
  let(:word_key_name) {SearchFactory.instance.word_key_name}
  let(:word_list) { SearchFactory.instance.word_list }
  let(:word_size) { SearchFactory.instance.word_size }
  let(:search_parameters) do 
                          {:association => tweet[:association],
                           :attribute_namespace => tweet[:attribute_namespace],
                           :search =>"should"} 
                         end
  
  before(:each) do
    @search = Rfizzy.new({:redis => R, :namespace => namespace }) 
    @search.create_index(tweet)
  end

  context "destroy an index with" do
    # context "a document that exist" do
    #   subject { @search.search_index(search_parameters) }
    #   it { should_not be_empty }
    #   it { should include(document_id) }
    # end    
    it "should no longer return results" do
      @search.destroy_index(tweet)
      results = @search.search_index(search_parameters)
      results.should_not include(document_id)
    end
  end
end