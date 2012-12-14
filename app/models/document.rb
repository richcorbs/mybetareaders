class Document < ActiveRecord::Base
  attr_accessible :doctype, :title, :user_id, :book_icon_color, :description, :deadline, :genre_id, :fiction, :comments_private, :accept_volunteers
  belongs_to :genre
  belongs_to :user
  has_many :volunteers, :dependent => :destroy
  has_many :paragraphs, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  has_many :paragraph_ratings, :through => :paragraphs
  has_many :paragraph_comments, :through => :paragraphs

  def criteria
    Criterium.where(:fiction => fiction).order(:criterium)
  end

  def overall_rating
    paragraph_count = paragraphs.count.to_f
    total_points    = 0.0
    #sum((other->'height_in')::integer)
    criteria.each do |criterium|
      count = paragraph_ratings.select( "sum((ratings->'#{criterium.criterium}')::integer) my_sum" )[0].my_sum.to_f
      total_points += count
    end
    rating = total_points / ( paragraph_count * criteria.count.to_f)
  end

  def text
    paragraphs.collect(&:text).join(' ')
  end

end
