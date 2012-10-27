module ApplicationHelper
  def time_on_date date
    date.strftime "%l:%M %p on %b %d, %Y"
  end
end
