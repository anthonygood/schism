class TeamMember < ActiveRecord::Base
  attr_accessible :email, :image_path, :name, :password_hash, :times_in_contests
  
  has_many :wins, {:class_name => 'Contest', :foreign_key => 'winner_id'} 
  has_many :losses, {:class_name => 'Contest', :foreign_key => 'loser_id'}
  
  validates_presence_of :name, :email
  
  
  #belongs_to :question, :through => :contests
  
  
  def self.random
    max = self.count 
	random = rand(max) + 1
    self.find random
  end
  
  def self.pick_two
    self.all.sample(2)
  end
  
  def self.biggest_streaker(group, option=:wins)
    group.sort do |a, b|
	  b.best_streak(option).length - a.best_streak(option).length
	end[0]
  end
  
  # returns the person with the most of a given attribute
  # pass an ActiveRecord collection of people and the attribute 
  # eg. TeamMember.with_most( group, :wins )
  
  def self.with_most(people, attribute)
    people.sort do |a,b|
	  b.send(attribute).length - a.send(attribute).length
	end[0]
  end
	
  def self.biggest_winner(people)
    self.with_most(people, :wins)
  end
  
  def self.biggest_loser(people)
    self.with_most(people, :losses)
  end
  
  def is?(other_team_member)
    self.id == other_team_member.id
  end
  
  def increment_contests
    self.times_in_contests += 1
	self.save
  end
  
  def signed_up?
    self.password_hash != nil
  end
  
  def to_s
    "#{self.name}, #{self.email}, #{self.image_path}"
  end
  
  def contests
	(self.wins + self.losses).sort {|a, b| a.created_at - b.created_at }
  end
  
  def winner?(contest)
    self.id == contest.winner.id
  end
  
  def loser?(contest)
    self.id == contest.loser.id
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
  
  # returns the longest streak for that team_member
  # pass in :losses for losing streak
  def best_streak( option=:wins )
    s = self.streaks( option ).sort {|a, b| b.length - a.length }
	# if empty, return an empty array, rather than nil
	return [] if s.empty?
	s[0]
  end
  
  # returns an array of the team_member's streaks
  # each streak is itself an array of contests
  
  # NOTE: this version suffers from N+1 queries
  def streaks( option=:wins )
  
    # set the method to call according to the option passed in
    condition = option == :losses ? :loser? : :winner?
	
    s = self.contests.inject([[]]) do |streak, contest|
      if self.send(condition, contest)
	    streak[-1] << contest
		streak
	  else
	    streak << []
	  end
    end
	
	s.reject {|arr| arr.empty? }
  end
  
  # this version just returns a number
  def streaks_light( option=:wins )
    str = ""
	regex = option == :losses ? /w+/ : /l+/
    s = self.contests.each { |contest| str << (self.id == contest.winner_id ? 'w' : 'l') }
	streaks = str.split(regex).compact
    return 0 if streaks.empty?
	streaks.sort.last.length
  end
  
  # uses the team_member.likelihoods method and trims its output 
  # to just outcomes greater than 1 vote
  def most_likely_to
    stats = self.likelihoods
	return [] if stats.empty?
    
	# removed the max condition, too restrictive
    # max = stats[0][1]

	stats.reject {|key, value| value < 2}
  end
  
  # as above, but the inverse
  def least_likely_to
    stats = self.likelihoods
	return [] if stats.empty?
	
	# min = stats[-1][1]
	stats.reject {|key, value| value > -2 }
  end
  
  # this method tallies likely and unlikely outcomes, 
  # and combines them in a single hash
  def likelihoods
    likely = self.tally(:wins)
	unlikely = self.tally(:losses)
	
	unlikely.each do |key, value|
	  likely[key] = (likely[key] || 0) - value
	end
	
	likely.sort_by {|key, value| value }.reverse
  end
  
  # returns a simple hash that tallies the votes the team_member received for each question
  # eg. { "Who would live longest?" => 2 }
  # pass in :losses to tally negative votes
  def tally(option=:wins)
    self.send(option).inject({}) do |hash, contest|
	  hash[contest.question.text] = (hash[contest.question.text] || 0) + 1
	  hash
	end
  end
  
  # IN PROGRESS -----------------------
  # this one returns an array of hashes
  # [ {"question" => "question_text", "id" => integer, "tally" => integer }, {...}, {...} ]
  def tally_with_id(option=:wins)
    self.send(option).inject([]) do |array, contest|
	  obj = {}
	  obj['id'] = contest.question.id
	  obj['question'] = contest.question.text
	  
	  if hash[contest.question.text]
	    obj['tally'] = hash[contest.question.text]['tally'] + 1
	  else
	    obj['tally'] = 1
	  end
	  
	  hash[contest.question.text] = obj
	  hash
	end
  end
  
  
  def firstname
    self.name.split(" ")[0]
  end
  
  
end
