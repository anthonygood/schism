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
  
end
