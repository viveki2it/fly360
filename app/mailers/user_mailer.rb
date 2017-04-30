class UserMailer < ActionMailer::Base
  default from: "MENUD <welcome@menud.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "#Erin is Coming We're revolutionizing healthy eating. You'll be the first to know."

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
