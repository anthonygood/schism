class Contest < ActiveRecord::Base
  attr_accessible :loser_id, :question_id, :winner_id
  
  belongs_to :winner, {:class_name => 'TeamMember', :foreign_key => 'winner_id'}
  belongs_to :loser, {:class_name => 'TeamMember', :foreign_key => 'loser_id'}
  belongs_to :question, {:class_name => 'Question', :foreign_key => 'question_id'}
  
  # ensure the associated records exist
  validates :question, :winner, :loser, :presence => true 
  
  # want to increment a Question's count attribute every time it's used
  after_create :update_question, :update_team_members
  
  def update_question
     self.question.increment
  end
  
  def update_team_members
    self.winner.increment_contests
	self.loser.increment_contests
  end
  
  def to_s
    "#{ self.question.text } Winner: #{ self.winner.name }. Loser: #{ self.loser.name }"
  end

  def self.range( ran=(1..10) ) # eg. Contest.range( 20-30 ), where 1 is the latest record
	min, max = ran.minmax
	total = (max - min) + 1
	
	# don't use 'count', because of deleted records, get the id directly
	db_records = self.last.id
	
	# larger number used to find the lower limit
	# eg. 1..10, (db_records - 10) will yield the lower limit - 1
	# + 1 because we want the record immediately after that
	# ( in a table with 100 records, record 90 is actually the eleventh! )
	db_lower_limit = (db_records - max) 
	db_upper_limit = (db_lower_limit + total)
	
	# finally, pop the query
    self.where( :id => (db_lower_limit..db_upper_limit) )
  end	
	
  
end
