class Document < ActiveRecord::Base
  attr_accessible :doctype, :title, :user_id, :book_icon_color, :description, :deadline, :genre_id, :fiction, :comments_private, :accept_volunteers, :paid, :active, :cost
  belongs_to :genre
  belongs_to :user
  has_many :charges
  has_many :feedbacks, :dependent => :destroy
  has_many :paragraphs, :dependent => :destroy
  has_many :paragraph_comments, :through => :paragraphs
  has_many :paragraph_ratings, :through => :paragraphs
  has_many :volunteers, :dependent => :destroy

  COST_PER_THOUSAND_WORDS = 100

  def calculate_cost_from_word_count
    # cost = 0 when word_count < 1000
    self.cost = (self.word_count / 1000.0).to_i * Document::COST_PER_THOUSAND_WORDS
  end

  def calculate_discounted_cost(coupon)
    coupon = Coupon.where(:code => coupon).first
    if coupon.percent
      discounted_cost = (cost * (1.0 - coupon.percent.to_f / 100.0)).to_i
    elsif coupon.amount.present?
      discounted_cost = cost - coupon.amount
    end
    discounted_cost
  end

  def calculate_stats_from_params_text(text)
    self.word_count = text.word_count
    self.sentence_count = text.sentence_count
    self.syllable_count = text.syllable_count
    self.word_count_three_or_more_syllables = text.word_count_three_or_more_syllables
  end

  def criteria
    Criterium.where(:fiction => fiction).order(:criterium)
  end

  def flesch_ease_scale
    (206.835 - 1.015 * self.word_count.to_f / self.sentence_count.to_f - 84.6 * self.syllable_count.to_f / self.word_count.to_f).to_i
  end

  def flesch_kincaid_grade_scale
    (0.39 * self.word_count.to_f / self.sentence_count.to_f + 11.8 * self.syllable_count.to_f / self.word_count.to_f - 15.59).to_i
  end

  def fog_scale
    (0.4 * ( (self.word_count.to_f / self.sentence_count.to_f) + 100.0 * (self.word_count_three_or_more_syllables.to_f / self.word_count.to_f) )).to_i
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

  def mark_as_paid
    self.paid = true
    self.save
  end

  def text
    paragraphs.collect(&:text).join(' ')
  end

end
