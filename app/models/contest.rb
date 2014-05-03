class Contest < ActiveRecord::Base
  attr_accessible :loser_id, :question_id, :winner_id
  
  belongs_to :winner, {:class_name => 'TeamMember', :foreign_key => 'winner_id'}
  belongs_to :loser, {:class_name => 'TeamMember', :foreign_key => 'loser_id'}
  belongs_to :question, {:class_name => 'Question', :foreign_key => 'question_id'}
  
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

  
end
