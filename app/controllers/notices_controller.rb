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
		@notice = Notice.new(notice_params)
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

    if notice_params[:active]
      Notice.update_all(active: false)
    end

 		if @notice.update(notice_params)
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
    	permit(:title, :content, :published)
	end
end
