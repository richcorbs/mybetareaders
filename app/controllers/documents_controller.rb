class DocumentsController < ApplicationController

  before_filter :require_login, :except => [:feedback]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])
    @document.user = current_user

    respond_to do |format|
      if @document.save
        params[:text].gsub!(/\r\n\r\n/,'\r\n')
        paragraphs = params[:text].split('\r\n')
        paragraphs.each do |paragraph|
          Paragraph.create(:document_id => @document.id, :text => paragraph) if paragraph.present?
        end
        format.html { redirect_to document_readers_path(@document.id), notice: 'Document was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    #@document.destroy

    respond_to do |format|
      format.html { redirect_to writing_path }
      format.json { head :no_content }
    end
  end

  def create_feedback
    @document = Document.find(params[:document_id])
    authorize! :create_feedback, Document, :message => "You must be the document owner to invite readers."
    @user = User.find_or_create_by_email(params[:email])
    @user.create_auth_token if @user.auth_token.blank?

    @feedback = Feedback.create(:user_id => @user.id, :document_id => params[:document_id])

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to :back, notice: 'Feedback was successfully created.' }
      end
    end
  end

  def feedback
    @document = Document.find(params[:id])
    if !current_user && params[:t]
      user = User.find_by_auth_token(params[:t])
      if user
        session[:user_id] = user.id
        @feedback = Feedback.find_by_document_id_and_user_id(params[:id], current_user.id)
        @feedback.update_attributes(:accepted_by_user => true) if @feedback
      else
        redirect_to "/"
      end
    elsif !current_user
      redirect_to login_path
    end
    
    authorize! :feedback, Document, :message => 'You do not have access to this document.'
    @feedback ||= Feedback.find_by_document_id_and_user_id(params[:id], current_user)
    @criteria = Criterium.where(:fiction => @document.fiction).order(:criterium)
    render 'feedback2'
  end

  def feedback_rating
    feedback = Feedback.find(params[:feedback_id])
    feedback.reader_rating = params[:stars]
    if feedback.save
      render :text => "rating saved"
    else
      render :text => "problem saving rating"
    end
  end

  def writer_flag_paragraph
    paragraph_comment = ParagraphComment.find(params[:paragraph_comment_id])
    paragraph         = paragraph_comment.paragraph
    paragraph_comment.writer_flagged = !paragraph_comment.writer_flagged
    paragraph_comment.save
    if paragraph_comment.writer_flagged?
      render :json => {:comment => "<i class='fail icon-flag'></i>", :paragraph => "<i class='fail icon-flag'></i>"}
    else
      paragraph.reload
      if paragraph.paragraph_comments.where(:writer_flagged => true).count > 0
        render :json => {:comment => '', :paragraph => "<i class='fail icon-flag'></i>"}
      else
        render :json => {:comment => '', :paragraph => ''}
      end
    end
  end

  def readers
    @document = Document.find(params[:id])
  end

  def whats_hot
    authorize! :whats_hot, :document, :message => 'You need to be logged in to view that page.'
    @documents = Document.order("id desc").where(:accept_volunteers => true).limit(6)
  end

  def reading
    @feedbacks = current_user.feedbacks.all(:include => :document, :order => :id)
  end

  def writing
    @documents = current_user.documents.all(:order => :id)
  end

  def volunteers
    @document   = Document.find(params[:id])
    @volunteers = @document.volunteers
  end

  def invite_volunteer
    @volunteer = Volunteer.find(params[:id])
    @feedback = Feedback.create( :user_id => @volunteer.user_id, :document_id => @volunteer.document_id )
    @volunteer.update_attributes( :invited => true )
    redirect_to :back
  end
end
