class ContestsController < ApplicationController
  
  def show
    # pick a random question
	@question = Question.random
	# pick the contestants
	@contestant_a, @contestant_b = TeamMember.pick_two  
  end
  
  private

  
end
