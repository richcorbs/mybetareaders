class UserMailer < ActionMailer::Base
  default from: "NO_REPLY@mybetareaders.com"

  def invitation_email(user, document)
    @user = user
    @document = document
    mail(:to => 'rich.corbridge@gmail.com', :subject => "MyBetaReaders Invitation to Read \"#{@document.title}\"")
  end

end
