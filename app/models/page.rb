class Page < ActiveRecord::Base
  attr_accessible :action, :content

  def self.last_page_for_action(action)
    Page.where(:action => action).last
  end

  def self.keep_only_ten(page_action)
    pages = Page.where(:action => page_action).order(:id)
    while pages.size > 10
      pages[0].destroy
      pages.delete_at(0)
    end
  end

end
