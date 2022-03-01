class UsersController < ApplicationController
  def index
  end

  def show
    session_id = 1
    @user = UserFacade.user_info(session_id)
  end

  def new
    @activities = RidbFacade.all_activities
  end

  def auth
    auth_hash = request.env['omniauth.auth']
    email = auth_hash['info']['email']
    user = User.find_by(email: email)
    if user.nil?
      redirect_to '/register'
    else
      redirect_to '/dashboard'
    end
  end

  def create
    UserService.user_create(params)
   if response.status == 200
     user = User.find(session[:user_id])
     flash[:success] = "Your Profile Has Been Created!"
     redirect_to dashboard(user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @duser.update_attributes(user_params)
      flash[:success] = "Your Information Was Updated"
      redirect_to dashboard_path
    else
      render action: :edit
    end
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user == nil
      flash[:error] = "User does not exist. Please try again."
      redirect_to "/login"
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Email or password is incorrect. Please try again."
      redirect_to "/login"
    end
  end

  def login_form
  end

  def logout
    session.destroy
    redirect_to root_path
  end


  def user_params
    params.require(:user).permit(:id, :user_name, :email, :street_address, :city, :state, :zipcode, :activity_preferences)
  end
end
