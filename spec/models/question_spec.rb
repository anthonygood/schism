require 'spec_helper'

describe Question do
  subject(:question) { Question.new(:text => "What if?")}
 
  it "isn't valid without a text property" do
    question = Question.create
	question.should_not be_valid
  end
  
  it "has a question" do
    question.text.should == "What if?"
  end
  
  
  it "has a default count value of 0" do
    question.count.should be 0
  end


  describe "#increment" do
    it "increments the question's count property" do
	  expect { question.increment }.to change { question.count }.by(1)
    end	  
  end
  
	
  describe ".random" do
    it "selects a random question" do 
	  Question.stub(:rand){0}
	  Question.should_receive(:rand)
	  
	  Question.random
	end
  end


end