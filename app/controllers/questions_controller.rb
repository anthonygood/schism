class QuestionsController < ApplicationController

  def index
    @questions = Question.all
	render "index"
  end
  
  def show
    @question = Question.find(params[:id])
  end

end
