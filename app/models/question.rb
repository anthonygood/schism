class Question < ActiveRecord::Base
  attr_accessible :count, :text
  
  # if a question is deleted, delete all its contests
  has_many :contests, { :class_name => 'Contest', :foreign_key => 'question_id', :dependent => :destroy }
  has_many :winners, :through => :contests 
  has_many :losers, :through => :contests
  
  validates_presence_of :text
  
  def increment
    self.count += 1
	self.save
  end
  
  def self.random
    self.first(:offset => rand(self.count))
  end
  
end
