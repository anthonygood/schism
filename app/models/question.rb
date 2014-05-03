class Question < ActiveRecord::Base
  attr_accessible :count, :text
  
  has_many :contests, { :class_name => 'Contest', :foreign_key => 'question_id' }
  has_many :winners, :through => :contests 
  has_many :losers, :through => :contests
  
  def increment
    self.count += 1
	self.save
  end
  
  def self.random
    max = self.count
	random = rand(max) + 1
    self.find random
  end
  
end
