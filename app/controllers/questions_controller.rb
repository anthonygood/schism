class QuestionsController < ApplicationController

  def index
    @questions = Question.all.sort_by { |question| question.text }
	render "index"
  end
  
  def show
    @question = Question.find(params[:id])
  end

end
