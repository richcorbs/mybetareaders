module ApplicationHelper
  def time_on_date date
    date.strftime "%l:%M %p on %b %d, %Y"
  end

  def signup_response
    responses = ['Sign me up!', 'This is for me!', "Pick me! Pick me!", "Can't wait to start reading!", "I wanna read this NOW!", "When can I start?", "This. Looks. Awesome!", "This is a book for me!"]
    responses[rand(responses.size)]
  end
end
