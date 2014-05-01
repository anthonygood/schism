class ContestsController < ApplicationController
  
  def show
    # pick a random question
	@question = Question.random
	# pick the contestants
	@contestant_a, @contestant_b = TeamMember.pick_two  
	render "show"
  end
  
  def submit
    logger.debug "*****"
    logger.debug "User clicked button for #{TeamMember.find(params[:winner]).name}"
	
	Contest.new(
	  :question_id => params[:question],
	  :winner_id => params[:winner],
	  :loser_id => params[:loser]
	).save
	
    redirect_to :back
  end
  
  private

  
end
