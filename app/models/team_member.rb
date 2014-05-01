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
    self.all.sample(2)
  end
  
  def is?(other_team_member)
    self.id == other_team_member.id
  end
  
end
