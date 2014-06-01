class TeamMembersController < ApplicationController
  include BCrypt
  
  def index
	unless logged_in?
      flash[:notice] = "You need to sign in to see the Quipper team."
	  return redirect_to "/sign-in"
	end
    
	@team = TeamMember.includes(:wins, :losses)
	#@biggest_winner = TeamMember.with_most(@team, :wins)
	#@biggest_loser = TeamMember.with_most(@team, :losses)
	
	@biggest_winner = TeamMember.biggest_winner(@team)
	@biggest_loser = TeamMember.biggest_loser(@team)
	
	#@best_streaker = TeamMember.biggest_streaker(@team, :wins)
	#@worst_streaker = TeamMember.biggest_streaker(@team, :losses)
	
	@best_streaker = get_best_streaker
	@best_streak = @best_streaker.streaks_light
	@worst_streaker = get_worst_streaker
	@worst_streak = @worst_streaker.streaks_light(:losses)
	
	
	#render :nothing => true
	
  end
  
  def show
	
  	unless logged_in?
      flash[:notice] = "You need to sign in to view someone's profile."
	  return redirect_to "/sign-in"
	end
	
	@team_member = TeamMember.find( params[:id])
	@heading = appellation
	
	@wins = @team_member.wins.includes(:question).all
	@losses = @team_member.losses.includes(:question).all
	
	@last_victory = @wins.last
	@last_defeat = @losses.last
	
	
	@win_streak = @team_member.streaks_light(:wins)
	@loss_streak = @team_member.streaks_light(:losses)
	

	
	if @team_member.most_likely_to 
	  @likeliest = format_likelihoods( @team_member.most_likely_to )
	end
	
	if @team_member.least_likely_to
	  @unlikeliest = format_likelihoods( @team_member.least_likely_to ).reverse
	end
  end
  
  def sign_in	
    # redirect if the user is already signed in
	return redirect_to team_member_path(session[:team_member_id]) if logged_in?
	
	render 'sign_in'

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
		
          # flash[:notice] = "You've logged in as #{@user.name}"
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

  def get_best_streaker
    @team.sort {|a,b| b.streaks_light(:wins) - a.streaks_light(:wins) }.first
  end
  
  def get_worst_streaker
    @team.sort {|a,b| b.streaks_light(:losses) - a.streaks_light(:losses) }.first
  end
    
  
  private
  

  def appellation
    ["Quipper Colleague","Quiz Stalwart","Education Apostle","Distributor of Wisdom","Courier of Knowledge","Knowledge Expert","Thinker of Big Ideas","Quipper Footsoldier", "Learner", "Professor of Truth and Light", "Quasher of Ignorance"].sample(1)[0]
  end
  
  # receives a 2D array, should return pretty 1D array
  def format_likelihoods(arr)
    pretty = arr.map do |question, likelihood|
	  [question.sub("Who would ", "").sub("?","").humanize, likelihood]
	end
	pretty
  end
  
  
  
end
