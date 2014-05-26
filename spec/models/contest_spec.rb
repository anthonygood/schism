require 'spec_helper'

describe Contest do

  subject(:contest){ Contest.new( )}
  
  context "validates" do
  
	  it "its associated question" do 
		contest = Contest.new(:winner_id => 1, :loser_id => 2, :question_id => nil)
		contest.should_not be_valid
	  end
	  
	  it "its associated winner" do
	    contest = Contest.new(:winner_id => nil, :loser_id => 2, :question_id => 1)
		contest.should_not be_valid
	  end
	  
	  it "its associated loser" do
	    contest = Contest.new(:winner_id => 1, :loser_id => nil, :question_id => 1)
		contest.should_not be_valid
	  end
  end
  

  describe "#update_question" do
  
    it "updates the attributes of its Question" do
	  
	  contest.question.should_receive(:increment)
	  contest.update_question	
	end
  end
  
  describe "#update_team_members" do
    
    
    it "calls the increment method of its winner and loser" do
	  
	  contest.winner.should_receive(:increment_contests)
	  contest.loser.should_receive(:increment_contests)
	  contest.update_team_members
	end
  
  end
  
  context "after saving" do
  
    it "updates the attributes of its Question" do
	  contest.stub(:winner => double(:increment_contests => 0))
	  contest.stub(:loser => double(:increment_contests => 0))
	  
      contest.question.should_receive(:increment)
      contest.save
	  puts contest.errors.full_messages
    end
	
	it "updates the attributes of its winner and loser" do
	  contest.stub(:question => double(:increment => 0))

	  contest.winner.should_receive(:increment_contests)
	  contest.loser.should_receive(:increment_contests)
	  contest.save
	  puts contest.errors.full_messages
	end
	
  end
  

end