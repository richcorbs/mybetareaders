class DocumentsController < ApplicationController

  before_filter :require_login, :except => [:feedback]

  rescue_from Pundit::NotAuthorizedError, :with => :unauthorized

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
    authorize Document
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    authorize @document
  end

  # POST /documents
  # POST /documents.json
  def create
    authorize Document
    @document = Document.new(params[:document])
    @document.calculate_stats_from_params_text(params[:text])
    if @document.word_count == 0
      flash[:notice] = "You need to include the text of your document."
      redirect_to :back and return if @document.word_count == 0
    end
    @document.user = current_user
    @document.cost = @document.calculate_cost_from_word_count

    respond_to do |format|
      if @document.save
        if @document.cost == 0 && @document.word_count < 1000
          @document.mark_as_paid
          flash[:notice] = "'#{@document.title.titleize}' has been marked as 'paid' since it was less than 1000 words."
        end
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

    authorize @document

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to writing_path, notice: 'Document was successfully updated.' }
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
    authorize @document
    @document.destroy

    respond_to do |format|
      format.html { redirect_to writing_path }
      format.json { head :no_content }
    end
  end

  def create_feedback
    @document = Document.find(params[:document_id])
    authorize @document
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
      end
    end

    authorize @document

    @feedback = Feedback.find_by_document_id_and_user_id(params[:id], current_user)
    if @feedback.accepted_by_user == false
      redirect_to :reading and return
    else
      @feedback.update_attributes(:accepted_by_user => true) if (@feedback.present?)
      @criteria = Criterium.where(:fiction => @document.fiction).order(:criterium)
      render 'feedback2'
    end
  end

  def feedback_complete
    @feedback = Feedback.find(params[:feedback_id])
    @document = @feedback.document
    authorize @document
    @feedback.update_attributes(:reader_feedback_complete => true)
    if @feedback.save
      render :text => 'OK'
    else
      render :text => 'FAILED'
    end
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
    authorize @document
  end

  def browse
    authorize Document
    if current_user.volunteers.count > 0
      @documents = Document.where("not id in (#{current_user.volunteers.collect(&:document_id).join(',')})").where(:accept_volunteers => true).where("user_id != ?", current_user.id).order("RANDOM()").limit(12)
    else
      @documents = Document.where(:accept_volunteers => true).where("user_id != ?", current_user.id).order("RANDOM()").limit(12)
    end
  end

  def reading
    authorize Document
    @feedbacks = current_user.feedbacks.all(:conditions => "accepted_by_user != false", :include => :document, :order => 'id desc')
    if @feedbacks.size > 0
      @volunteers = current_user.volunteers.all(:conditions => "document_id not in (#{@feedbacks.collect(&:document_id).join(',')})", :include => :document, :order => 'id desc')
    else
      @volunteers = current_user.volunteers.all(:include => :document, :order => 'id desc')
    end
  end

  def writing
    authorize Document
    @documents = current_user.documents.all(:order => 'id desc')
  end

  def volunteers
    @document   = Document.find(params[:id])
    @volunteers = @document.volunteers.find(:all, :include => :user, :order => 'users.email')
    authorize @document
  end

  def invite_volunteer
    @volunteer = Volunteer.find(params[:id])
    @document  = @volunteer.document
    authorize @document
    @feedback = Feedback.create( :user_id => @volunteer.user_id, :document_id => @volunteer.document_id )
    @volunteer.update_attributes( :invited => true )
    redirect_to :back
  end

  def uninvite_volunteer
    @document = Document.find(params[:id])
    @volunteer = Volunteer.find(params[:volunteer_id])
    Feedback.where(:user_id => @volunteer.user_id, :document_id => @document.id).first.destroy
    authorize @document
    @volunteer.update_attributes( :invited => false )
    redirect_to :back
  end

  def pay_for_document
    @user = current_user
    @document = Document.find(params[:id])

    if @document.cost == 0 && @document.word_count < 1000
      @document.mark_as_paid
      flash[:notice] = "'#{@document.title.titleize}' has been marked as 'paid' since it was less than 1000 words."
      redirect_to :action => :writing
    end

    return if request.method == 'GET'

    redirect_to :action => :writing if @document.paid?

    if params[:submit] != "Pay with this credit card."
      @user.update_attributes(params[:user])
    end

    @user.reload
    cost   = params[:coupon].present? ? @document.calculate_discounted_cost(params[:coupon]) : @document.cost
    credit = @document.credit_to_apply(cost)
    cost  -= credit

    if cost > 50
      stripe_charge = Stripe::Charge.create(
                 :amount => cost,
                 :currency => 'usd',
                 :customer => @user.stripe_customer_id,
                 :description => "mybetareaders.com charge for document #{@document.id}")
      charge = Charge.new_from_stripe_charge(@document.id, stripe_charge, current_user, params[:coupon])
      #<Stripe::Charge:0x3fc6800627d8 id=ch_0x4MvWU6UlQMzW> JSON: {"id":"ch_0x4MvWU6UlQMzW","amount":200,"amount_refunded":0,"created":1356013356,"currency":"usd","customer":"cus_0x35t3fg4eUy2o","description":"mybetareaders.com charge for document 5","dispute":null,"failure_message":null,"fee":36,"invoice":null,"livemode":false,"object":"charge","paid":true,"refunded":false,"card":{"address_city":null,"address_country":null,"address_line1":null,"address_line1_check":null,"address_line2":null,"address_state":null,"address_zip":null,"address_zip_check":null,"country":"JP","cvc_check":"pass","exp_month":12,"exp_year":2012,"fingerprint":"fKWNh904PKFHob6K","last4":"0000","name":"undefined","object":"card","type":"JCB"},"fee_details":[{"type":"stripe_fee","amount":36,"application":null,"currency":"usd","description":"Stripe processing fees"}]}
      charge.update_attributes(:credit_applied => credit) if credit.present?
      charge.update_attributes(:coupon => params[:coupon]) if params[:coupon].present?
      if stripe_charge.paid == true
        @document.update_attributes(:paid => true)
        flash[:notice] = "Thank you for your payment for \"#{@document.title.titleize}\"."
        redirect_to :action => :writing
      else
        flash[:notice] = "Your payment failed: #{stripe_charge.failure_message}"
      end
    else
      charge = Charge.new_for_free_document(@document, current_user)
    end

  end

  private

end
