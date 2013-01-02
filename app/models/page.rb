class Page < ActiveRecord::Base
  attr_accessible :action, :content

  def self.last_page_for_action(action)
    Page.where(:action => action).last
  end

end
