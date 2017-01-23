class NoticesController < ApplicationController
  before_action :require_signin
  before_action :require_admin

	def index
		@notices = Notice.all
	end

  def show
    @notice = Notice.find(params[:id])
	end

  def new
  	@notice = Notice.new
	end

  def create
    temp_params = notice_params
    temp_params[:slug] = temp_params[:title].parameterize
    
		@notice = Notice.new(temp_params)
		if @notice.save
  		redirect_to @notice, notice: "Notice successfully registered!"
		else
      flash.now[:error] = @notice.errors.full_messages
  		render :new
		end
	end

  def edit
    @notice = Notice.find(params[:id])
	end

  def update
    @notice = Notice.find(params[:id])
    temp_params = notice_params
    temp_params[:slug] = temp_params[:title].parameterize

 		if @notice.update(temp_params)
    	redirect_to @notice, notice: "Notice successfully updated!"
  	else
    	render :edit
  	end
	end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy

		redirect_to notices_url, notice: "Notice successfully deleted!"
	end

  def notice_params
  		params.require(:notice).
    	permit(:title, :content, :published, :slug)
	end
end
