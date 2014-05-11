class TeamMembersController < ApplicationController
  require 'bcrypt'
  
  def index
    @team = TeamMember.all
  end
  
  def show
    @team_member = TeamMember.find(params[:id])
  end
  
  def sign_in	

  end
  
  def check_user
  	email = params[:email] << "@quipper.com"
	
	@user = TeamMember.find_by_email( email )
	
		  puts "**********************************************************************"
	  puts @user.to_s
	
	if @user
	  
	  flash[:notice] = "User #{@user.name} found for that email address."
	else 
	  flash[:alert] = "No user was found with that email address."
	end
	
	redirect_to "/sign-in"
  
  end
  
  
  private
  
  def log_in
  
  end
  
  def register
  end
  
end
