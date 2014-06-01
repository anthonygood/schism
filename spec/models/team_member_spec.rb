require 'spec_helper'

describe TeamMember do
  subject(:team_member) { TeamMember.new( :id => 1, :name => 'Anthony Good', 	:email => 'anthony@quipper.com'	) }
  
  it "has a default value of 0 for 'times_in_contests'" do
    team_member.times_in_contests.should be 0
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
  
  end