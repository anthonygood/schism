class TeamMembersController < ApplicationController
  include BCrypt
  
  def index
    @team = TeamMember.all
  end
  
  def show
    @team_member = TeamMember.find(params[:id])
	@last_victory = @team_member.wins[-1]
	@last_defeat = @team_member.losses[-1]
  end
  
  def sign_in	

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
		
        flash[:notice] = "Password matches, logging in..."
		return redirect_to :back
		else
		flash[:alert] = "Wrong password!"
		return redirect_to :back
		end
      else
	    # team_member found, but not registered yet
		# register their account
		hashed_password = Password.create( submitted_password )
		@user.update_attribute( :password_hash, hashed_password )
		flash[:notice] = "Account created!"
      end		
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
