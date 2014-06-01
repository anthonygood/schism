require 'spec_helper'

describe TeamMember do
  subject(:team_member) { TeamMember.create( :name => 'Anthony Good', 	:email => 'anthony@quipper.com'	) }
  let(:opponent) { TeamMember.create(:name => "Jerry", :email => "jez@google.com") }
  let(:question) { Question.create(:text => "What if?") }
  
  it "has a default value of 0 for 'times_in_contests'" do

    team_member.times_in_contests.should be 0
  end
  
  it "destroys associated records when destroyed" do
    opponent # invoke the let
	question # invoke the let
    team_member.wins.create(:loser_id => 1, :question_id => 1)
    expect{ team_member.destroy }.to change { Contest.count }.by -1
  end
  
  context "validates" do
    it "its name" do
	  team_member = TeamMember.new( :email => 'abc@gmail.com' )
	  team_member.should_not be_valid
	end
	
	it "its email" do
	  team_member = TeamMember.new( :name => 'Anthony Good' )
	  team_member.should_not be_valid
	end
  end
  
  
  describe ".increment_contests" do
    it "increments 'times_in_contests'" do
	  expect { team_member.increment_contests }.to change { team_member.times_in_contests }.from(0).to(1)
	
	end 
  end
  
  describe ".signed_up?" do
    it "checks the user has a password" do
	  team_member.should_receive(:password_hash)
	  
	  team_member.signed_up?
	
	end
  
  end
  
  describe ".winner?" do
	
    it "returns true if team_member won the contest" do
	  team_member.save
	  contest = double(:winner => team_member)

	  team_member.winner?(contest).should == true
	end
	
	it "returns false if team_member lost the contest" do
	  contest = double(:winner => double(:id => 2))

	  team_member.winner?(contest).should == false
	end
  
  end
  
  describe ".loser?" do
	
    it "returns true if team_member lost the contest" do
	 #team_member.save
	  contest = double(:loser => team_member)

	  team_member.loser?(contest).should == true
	end
	
	it "returns false if team_member won the contest" do
	  contest = double(:loser => double(:id => 2))

	  team_member.loser?(contest).should == false
	end
  
  end
  
  describe ".in_contest?" do
    context "when a participant" do
	
	  it "returns true if team_member won" do	  
		
	    contest = double( { :winner => team_member, :loser => double(:id => 2) } )
		
		team_member.in_contest?(contest).should be true
	  end
	  
	  it "returns true if team_member lost" do
	    contest = double( { :winner => double(:id => 2), :loser => team_member } )
		
		team_member.in_contest?(contest).should be true
	  end
	
	end
	
	context "when a non-participant" do
	
		it "returns false" do	  
		
	    contest = double( { :winner => double(:id =>2), :loser => double(:id => 3) } )
		
		team_member.in_contest?(contest).should be false
	  end
	  
	
	end
	
  end
  
  describe ".streaks_light" do
    before :each do 
	  team_member.save # have to save to create contests
	  opponent = TeamMember.create(:name => "Jerry", :email => "jez@google.com")
	  question = Question.create(:text => "What if?")
	end
	
    it "returns 2 for a winstreak of 2" do
	  2.times { team_member.wins.create(:question_id => 1, :loser_id => 2) }
	  
	  team_member.streaks_light.should be 2
	end
	
	it "returns 50 for a winstreak of 50" do
	  50.times { team_member.wins.create(:question_id => 1, :loser_id => 2) }
	  team_member.streaks_light.should be 50
	end
	
	it "correctly counts consecutive victories only" do
	  team_member.wins.create(:question_id => 1, :loser_id => 2)
	  team_member.losses.create(:question_id => 1, :winner_id => 2)
	  team_member.wins.create(:question_id => 1, :loser_id => 2)
	  
	  team_member.streaks_light.should be 1
	  
	end
	
	it "returns the best streak of wins by default" do
	  2.times { team_member.wins.create(:question_id => 1, :loser_id => 2)}
	  3.times { team_member.losses.create(:question_id => 1, :winner_id => 2) }
	  
	  team_member.streaks_light.should be 2
	end
	
	it "returns the losing streak if called with a :losses parameter" do
	  2.times { team_member.wins.new(:question_id => 1, :loser_id => 2).save }
	  3.times { team_member.losses.new(:question_id => 1, :winner_id => 2).save }
	  
	  team_member.streaks_light(:losses).should be 3
	end
  
  end
  
  end