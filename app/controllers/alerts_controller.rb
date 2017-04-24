class AlertsController < ApplicationController
  before_action :require_signin
  before_action :require_admin

	def index
		@alerts = Alert.order("id ASC").all
	end

  def show
    @alert = Alert.find(params[:id])
	end

  def new
  	@alert = Alert.new
	end

	def create
		@alert = Alert.new(alert_params)
		if @alert.save
  		redirect_to @alert, notice: "Alert successfully registered!"
		else
      flash.now[:error] = @alert.errors.full_messages
  		render :new
		end
	end

  def edit
    @alert = Alert.find(params[:id])
	end

  def update
    @alert = Alert.find(params[:id])

    if alert_params[:active]
      Alert.update_all(active: false)
    end

 		if @alert.update(alert_params)
    	redirect_to @alert, notice: "Alert successfully updated!"
  	else
    	render :edit
  	end
	end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy

		redirect_to alerts_url, alert: "Alert successfully deleted!"
	end

  def active
    @alert = Alert.find(params[:id])
    Alert.update_all(active: false)
 		if @alert.update({ active: true })
    	redirect_to alerts_url, notice: "Alert successfully updated!"
  	end
  end

  def deactive
    @alert = Alert.find(params[:id])
    if @alert.update({ active: false })
    	redirect_to alerts_url, notice: "Alert successfully updated!"
  	end
  end

  private

	def alert_params
  		params.require(:alert).
    	permit(:title, :content, :active)
	end
end
