class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_admin, only: [:index]
  before_action :require_correct_user_or_admin, only: [:edit, :update, :show, :destroy]  

	def index
		@users = User.all
	end

	def show
    @message = Message.new
    @user = User.find(params[:id])
	end

	def new
  	@user = User.new
	end

	def create
  		@user = User.new(user_params)
  		if @user.save
        session[:user_id] = @user.id
    		redirect_to @user, notice: "Thanks for signing up!"
        UserMailer.welcome_email(@user).deliver
  		else
    		render :new
  		end
	end

	def edit
    @user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
 		if @user.update(user_params)
    	redirect_to @user, notice: "Account successfully updated!"
  	else
    	render :edit
  	end
	end

	def destroy
      @user = User.find(params[:id])
  		@user.facilities.each do |f|
        f.user = nil
        f.save
      end
      @user.destroy
      if session[:user_id] == @user.id
        session[:user_id] = nil #session[:user_id] = nil
      end
      
  		redirect_to root_url, alert: "Account successfully deleted!"
	end

	private

	def user_params
  		params.require(:user).
    	permit(:name, :email, :password, :password_confirmation, :activation_email_sent)
	end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end






end
