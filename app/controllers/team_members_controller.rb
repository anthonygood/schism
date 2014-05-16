class TeamMembersController < ApplicationController
  include BCrypt
  
  def index
	unless logged_in?
      flash[:notice] = "You need to sign in to see the Quipper team."
	  return redirect_to "/sign-in"
	end
    @team = TeamMember.all
  end
  
  def show
    @team_member = TeamMember.find(params[:id])
  	unless logged_in?
      flash[:notice] = "You need to sign in to view #{@team_member.firstname}'s profile."
	  return redirect_to "/sign-in"
	end
	
	@last_victory = @team_member.wins.last
	@last_defeat = @team_member.losses.last
	@contests = @team_member.contests
	@heading = appellation
  end
  
  def sign_in	

  end
  
  def contests
    @team_member = TeamMember.find( params[:id] )
	@contests = @team_member.contests
	@heading = "Contests"
  end
  

  def check_user
  	email = params[:email] << "@quipper.com"
	@user = TeamMember.find_by_email( email )
	submitted_password = params[:password]
	
	if submitted_password.empty?
	  flash[:alert] = "Enter a password, you crazy person."
	  return redirect_to :back
	end
	
	# if the entered email address matches a user ...
	if @user
      # check if user has already registered (password exists)
      if @user.password_hash
	    # check their password is correct
		if Password.new( @user.password_hash) == submitted_password 
		
          flash[:notice] = "You've logged in as #{@user.name}"
		  session[:team_member_id] = @user.id
		  return redirect_to '/contests/new'
		else
		  flash[:alert] = "Email is registered, but not with that password."
		  return redirect_to :back
		end
      else
	    # team_member found, but not registered yet
		# register their account
		hashed_password = Password.create( submitted_password )
		@user.update_attribute( :password_hash, hashed_password )
		flash[:notice] = "Account created for #{@user.name}!"
		session[:team_member_id] = @user.id
		redirect_to '/contests/new'
      end		
	else 
	  flash[:alert] = "No user was found with that email address. Are you sure you work for Quipper?"
	  redirect_to "/sign-in"
	end
  
  end

  def logout
    session[:team_member_id] = nil
	redirect_to '/sign-in'
  end
  
  
  private
  
  def appellation
    ["Quipper Colleague","Quiz Stalwart","Education Apostle","Distributor of Wisdom","Courier of Knowledge","Knowledge Expert","Thinker of Big Ideas","Quipper Footsoldier", "Learner", "Professor of Truth and Light", "Quasher of Ignorance"].sample(1)[0]
  end
  
  
end
