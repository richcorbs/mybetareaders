class UsersController < ApplicationController

  before_filter :require_login, :except => [:new, :create]
  before_filter :require_admin, :only => [:index, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    authorize User
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    authorize @user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    authorize User
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  # POST /users
  # POST /users.json
  def create
    authorize User
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
      else
        format.html { redirect_to signup_path }
      end
    end
  end

  def change_password
    @user = current_user
    authorize @user
    if params[:password] == params[:password_confirm]
      @user.password = params[:password]
      @user.save
      redirect_to user_home_path and return
    else
      redirect_to :back, :notice => "Passwords must match" and return
    end

  end
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize @user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def preferences
    @user = current_user
    authorize @user
    if @user.reading_preferences.nil?
      @user.reading_preferences = {}
      @user.save
    end
  end

  def preferences_update
    @user = current_user
    authorize @user
    #@user.reading_preferences = {} if @user.reading_preferences.nil?
    @user.reading_level = params[:reading_level]
    Genre.all.each do |g|
      @user.reading_preferences[g.genre] = (params[g.genre] && params[g.genre] == '1') ? true : false
    end
    @user.save
    redirect_to :back
  end
end
