class Question < ActiveRecord::Base
  attr_accessible :count, :text
  
  has_many :contests
  
  def self.random
    max = self.count
	random = rand(max) + 1
    self.find random
  end
  
end
