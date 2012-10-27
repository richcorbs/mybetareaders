class DoctypesController < ApplicationController
  # GET /doctypes
  # GET /doctypes.json
  def index
    @doctypes = Doctype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doctypes }
    end
  end

  # GET /doctypes/1
  # GET /doctypes/1.json
  def show
    @doctype = Doctype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doctype }
    end
  end

  # GET /doctypes/new
  # GET /doctypes/new.json
  def new
    @doctype = Doctype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doctype }
    end
  end

  # GET /doctypes/1/edit
  def edit
    @doctype = Doctype.find(params[:id])
  end

  # POST /doctypes
  # POST /doctypes.json
  def create
    @doctype = Doctype.new(params[:doctype])

    respond_to do |format|
      if @doctype.save
        format.html { redirect_to @doctype, notice: 'Doctype was successfully created.' }
        format.json { render json: @doctype, status: :created, location: @doctype }
      else
        format.html { render action: "new" }
        format.json { render json: @doctype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /doctypes/1
  # PUT /doctypes/1.json
  def update
    @doctype = Doctype.find(params[:id])

    respond_to do |format|
      if @doctype.update_attributes(params[:doctype])
        format.html { redirect_to @doctype, notice: 'Doctype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doctype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctypes/1
  # DELETE /doctypes/1.json
  def destroy
    @doctype = Doctype.find(params[:id])
    @doctype.destroy

    respond_to do |format|
      format.html { redirect_to doctypes_url }
      format.json { head :no_content }
    end
  end
end
