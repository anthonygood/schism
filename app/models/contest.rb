class Contest < ActiveRecord::Base
  attr_accessible :loser_id, :question_id, :winner_id
  
  belongs_to :winner, {:class_name => 'TeamMember', :foreign_key => 'winner_id'}
  belongs_to :loser, {:class_name => 'TeamMember', :foreign_key => 'loser_id'}
  belongs_to :question
  
  def to_s
    "#{ self.question.text } Winner: #{ self.winner.name }. Loser: #{ self.loser.name }"
  end

  
end
