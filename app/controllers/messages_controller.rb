class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    #@user = User.find(session[:user_id])

    if @message.valid?
      redirect_to "https://intersteller500.herokuapp.com"
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :new
    end
  end

private

  def message_params
    params.require(:message).permit(:name, :phone, :content)
  end

end
