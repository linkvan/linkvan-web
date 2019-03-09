class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_admin, only: [:index]
  before_action :require_correct_user_or_admin, only: [:edit, :update, :show, :destroy]

  require 'csv'

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

	def show
    @message = Message.new
    @user = User.find(params[:id])
    @users = User.all
	end

  def toggle_verify
    @current_user = User.find(session[:user_id])
    @user = User.find(params[:id])
    # if user is an admin, do not allow them to change status of another admin
    # should also make sure admin is the one making the request
    if @user.verified == true
      @user.update_attribute(:verified, false)
    else
      @user.update_attribute(:verified, true)
    end
    @user.save
    render json: {verified: @user.verified}
  end

	def new
  	@user = User.new
	end

	def create
  		@user = User.new(user_params)
      @user.update_attribute(:activation_email_sent, true)
  		if @user.save
        session[:user_id] = @user.id
    		redirect_to @user, notice: "Thanks for signing up!"
  		else
        flash.now[:error] = @user.errors.full_messages
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
    	permit(:name, :email, :password, :password_confirmation, :activation_email_sent, :phone_number)
	end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end

end
