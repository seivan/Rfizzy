require "spec_helper"

describe Rfizzy, "initialize" do
  
  context "should raise error if" do
    it "initialize with no redis passed to it" do
      lambda { Rfizzy.new() }.should raise_error
    end
  end
  context "initialize with arguments" do
    subject  {Rfizzy.new(:namespace => namespace, :redis => R) }
    let(:namespace) { "FullTextSearch" }
    it { should be_an_instance_of Rfizzy }
    it { subject.namespace.should  == namespace }
  end

  context "initialize with blank namespace" do
    subject  {Rfizzy.new(:namespace => namespace, :redis => R) }
    let(:namespace) { "  " }
    it { subject.namespace.should  == "Rfizzy:" }  
  end

  context "initialize with no namespace" do
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
end
