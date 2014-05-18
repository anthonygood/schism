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
  
  def self.biggest_streaker(people, option=:wins)
    people.sort do |a, b|
	  b.send(option).length - a.send(option).length
	end.first
  end
  
  # pass an array and attribute you want to sort it by
  def self.with_most(people, attribute)
    people.sort do |a,b|
	  b.send(attribute).length - a.send(attribute).length
	end[0]
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
	their_contests = self.wins + self.losses
	their_contests.sort {|a, b| a.created_at - b.created_at }
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
  
  def best_streak( option=:wins )
    self.streaks( option ).sort {|a, b| b.length - a.length }[0]
  end
  
  def streaks( option=:wins )
  
    # set the method to call according to the option passed in
    condition = option == :losses ? :loser? : :winner?
	
    streaks = self.contests.inject([[]]) do |streak, contest|
      if self.send(condition, contest)
	    streak[-1] << contest
		streak
	  else
	    streak << []
	  end
    end
	streaks.reject {|arr| arr.empty? }
  end
  
  def most_likely_to
    stats = self.likelihoods
    max = stats[0][1]
	stats.reject {|key, value| value < max  || value < 2}
  end
  
  def least_likely_to
    stats = self.likelihoods
	min = stats[-1][1]
	stats.reject {|key, value| value > min || value > -2 }
  end
  
  def likelihoods
    likely = self.tally(:wins)
	unlikely = self.tally(:losses)
	
	unlikely.each do |key, value|
	  likely[key] = (likely[key] || 0) - value
	end
	
	likely.sort_by {|key, value| value }.reverse
  end
  
  # returns a simple hash
  # { "question" => integer }
  def tally(option=:wins)
    self.send(option).inject({}) do |hash, contest|
	  hash[contest.question.text] = (hash[contest.question.text] || 0) + 1
	  hash
	end
  end
  
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
