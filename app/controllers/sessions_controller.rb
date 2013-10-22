#Fuente: http://ruby.railstutorial.org/chapters/sign-in-sign-out#top

class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
    	# sesion mientras este abierto el browser
    	sign_in(user)
    	redirect_to :projects
  	else
    	flash[:error] = 'Invalid email/password combination' # Not quite right!
      	render 'new'
  	end
  end

  def destroy
  	sign_out
    redirect_to :root
  end

end
