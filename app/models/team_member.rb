class TeamMember < ActiveRecord::Base
  attr_accessible :email, :image_path, :name, :password_hash, :times_in_contests
  
  has_many :wins, {:class_name => 'Contest', :foreign_key => 'winner_id'} 
  has_many :losses, {:class_name => 'Contest', :foreign_key => 'loser_id'}
  
  
  #belongs_to :question, :through => :contests
  
  
  def self.random
    max = self.count 
	random = rand(max) + 1
    self.find random
  end
  
  def self.pick_two
    self.all.sample(2)
  end
  
  def is?(other_team_member)
    self.id == other_team_member.id
  end
  
  def increment_contests
    self.times_in_contests += 1
	self.save
  end
  
  def to_s
    "#{self.name}, #{self.email}, #{self.image_path}"
  end
  
  def contests
	their_contests = self.wins + self.losses
	their_contests.sort {|a, b| a.created_at - b.created_at }
  end
  
  def winner?(contest)
    self.id == contest.winner.id
  end
  
  def in_contest?(contest)
    self.id == contest.winner.id || self.id == contest.loser.id
  end
  
  def opponent(contest)
    if self.winner?(contest)
	  opponent = contest.loser
	else
	  opponent = contest.winner
	end
	opponent
  end
  
  def streak(option=:wins)
    str = ""
	regex = option == :losses ? (/w+?/) : (/l+?/)
	
	# build a simple string to represent wins and losses
	# eg. 'wwlwllwlll'
    self.contests.each do |contest|
	  x = self.winner?(contest) ? "w" : "l"
	  str << x
	end
	
	# split the string according to option passed in,
	# and count longest match
	wins = str.split(regex)
	wins.sort.reverse[0].length
  end
  
  def firstname
    self.name.split(" ")[0]
  end
  
end
