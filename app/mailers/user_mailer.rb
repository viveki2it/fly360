class UserMailer < ActionMailer::Base
  default from: "360Fly <welcome@menud.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "#360Fly is changing the game…again!"

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
