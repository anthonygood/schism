class TeamMember < ActiveRecord::Base
  attr_accessible :email, :image_path, :name, :password_hash, :times_in_contests
  
  has_many :wins, {:class_name => 'Contest', :foreign_key => 'winner_id'} 
  has_many :losses, {:class_name => 'Contest', :foreign_key => 'loser_id'}
  
  
  def self.random
    max = self.count 
	random = rand(max) + 1
    self.find random
  end
  
  def self.pick_two
    contestants = [self.random, self.random]
	# go again if the same was chosen twice
	pick_two unless contestants.uniq.length == contestants.length
	contestants
  end
  
end
