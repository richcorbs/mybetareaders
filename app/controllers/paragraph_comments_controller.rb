class ParagraphCommentsController < ApplicationController
  # GET /paragraph_comments
  # GET /paragraph_comments.json
  def index
    @paragraph_comments = ParagraphComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paragraph_comments }
    end
  end

  # GET /paragraph_comments/1
  # GET /paragraph_comments/1.json
  def show
    @paragraph_comment = ParagraphComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paragraph_comment }
    end
  end

  # GET /paragraph_comments/new
  # GET /paragraph_comments/new.json
  def new
    @paragraph_comment = ParagraphComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paragraph_comment }
    end
  end

  # GET /paragraph_comments/1/edit
  def edit
    @paragraph_comment = ParagraphComment.find(params[:id])
  end

  # POST /paragraph_comments
  # POST /paragraph_comments.json
  def create
    @paragraph_comment = ParagraphComment.new(params[:paragraph_comment])
    @document          = @paragraph_comment.paragraph.document
    authorize @paragraph_comment
    @paragraph_comment.user_id = current_user.id

    respond_to do |format|
      if @paragraph_comment.save
        format.html { render :partial => 'documents/paragraph_comment', :layout => false, :object => @paragraph_comment and return}
        format.json { render json: @paragraph_comment, status: :created, location: @paragraph_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @paragraph_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paragraph_comments/1
  # PUT /paragraph_comments/1.json
  def update
    @paragraph_comment = ParagraphComment.find(params[:id])

    respond_to do |format|
      if @paragraph_comment.update_attributes(params[:paragraph_comment])
        format.html { redirect_to @paragraph_comment, notice: 'Paragraph comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paragraph_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paragraph_comments/1
  # DELETE /paragraph_comments/1.json
  def destroy
    @paragraph_comment = ParagraphComment.find(params[:id])
    @paragraph_comment.destroy

    respond_to do |format|
      format.html { redirect_to paragraph_comments_url }
      format.json { head :no_content }
    end
  end
end
