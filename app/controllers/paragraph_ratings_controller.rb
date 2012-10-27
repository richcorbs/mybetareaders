class ParagraphRatingsController < ApplicationController
  # GET /paragraph_ratings
  # GET /paragraph_ratings.json
  def index
    @paragraph_ratings = ParagraphRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paragraph_ratings }
    end
  end

  # GET /paragraph_ratings/1
  # GET /paragraph_ratings/1.json
  def show
    @paragraph_rating = ParagraphRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paragraph_rating }
    end
  end

  # GET /paragraph_ratings/new
  # GET /paragraph_ratings/new.json
  def new
    @paragraph_rating = ParagraphRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paragraph_rating }
    end
  end

  # GET /paragraph_ratings/1/edit
  def edit
    @paragraph_rating = ParagraphRating.find(params[:id])
  end

  # POST /paragraph_ratings
  # POST /paragraph_ratings.json
  def create
    @paragraph_rating = ParagraphRating.new(params[:paragraph_rating])

    respond_to do |format|
      if @paragraph_rating.save
        format.html { redirect_to @paragraph_rating, notice: 'Paragraph rating was successfully created.' }
        format.json { render json: @paragraph_rating, status: :created, location: @paragraph_rating }
      else
        format.html { render action: "new" }
        format.json { render json: @paragraph_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_or_update
    @paragraph_rating = ParagraphRating.find_or_create_by_paragraph_id_and_user_id(params[:paragraph_id], current_user.id)
    @criteria         = @paragraph_rating.paragraph.document.criteria
    if @paragraph_rating.ratings.blank?
      @paragraph_rating.ratings = {}
      @criteria.each do |c|
        @paragraph_rating.ratings[c.criterium] = 0
      end
      @paragraph_rating.save
    end
    @paragraph_rating.reload
    @paragraph_rating.update_from_params(params)
    render :nothing => true
  end

  def set_bookmark
    @paragraph = Paragraph.find(params[:paragraph_id])
    @document  = @paragraph.document
    @feedback  = Feedback.find_by_user_id_and_document_id( current_user.id, @document.id )
    @feedback.bookmark = @paragraph.id
    @feedback.save
    render :text => "<i class='icon-bookmark'></i>"
  end

  # PUT /paragraph_ratings/1
  # PUT /paragraph_ratings/1.json
  def update
    @paragraph_rating = ParagraphRating.find(params[:id])

    respond_to do |format|
      if @paragraph_rating.update_attributes(params[:paragraph_rating])
        format.html { redirect_to @paragraph_rating, notice: 'Paragraph rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paragraph_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paragraph_ratings/1
  # DELETE /paragraph_ratings/1.json
  def destroy
    @paragraph_rating = ParagraphRating.find(params[:id])
    @paragraph_rating.destroy

    respond_to do |format|
      format.html { redirect_to paragraph_ratings_url }
      format.json { head :no_content }
    end
  end
end
