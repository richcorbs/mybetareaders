module DocumentsHelper
  def book_icon_background_color document
    if document.active? && document.book_icon_color
      document.book_icon_color
    elsif document.active?
      'green'
    else
      '#f0f0f0'
    end
  end
end
