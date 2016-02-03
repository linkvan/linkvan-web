class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    #@user = User.find(session[:user_id])

    if @message.valid?
      UserMailer.new_message(@message, current_user).deliver
      current_user.activation_email_sent = true
      current_user.save
      redirect_to current_user, notice: "Your messages has been sent."
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