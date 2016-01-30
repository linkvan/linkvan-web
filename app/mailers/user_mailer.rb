class UserMailer < ActionMailer::Base
  default from: "HeyDoggyNotification@gmail.com"
 
  def welcome_email(user)
  	@url  = 'http://linkvan.herokuapp.com/'
    @user = user
    mail(to: @user.email, 
    	subject: 'Welcome to My Awesome Site')
  end
end
