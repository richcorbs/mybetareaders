class PagesController < ApplicationController

  before_filter :public_pages, :include => [:how_it_works, :pricing]

  def create
    authorize Page
    @page = Page.create(:action => params[:page_action], :content => params[:page_content])
    flash[:notice] = "Page #{@page.action} created."
    redirect_to :action => :index
  end

  def destroy
    authorize Page
    @page = Page.find(params[:id])
    flash[:notice] = "Page #{@page.action} deleted."
    @page.destroy
    redirect_to :action => :index
  end
  def edit
    @page = Page.find(params[:id])
    authorize @page
  end

  def features
  end

  def home
    authorize Page, :public?
  end

  def how_it_works
    authorize Page, :public?
  end

  def index
    @pages = Page.select("distinct(action)").order(:action)
    authorize Page
  end

  def new
    @page = Page.new
    authorize @page
  end

  def pricing
    authorize Page, :public?
  end

  def update
    authorize Page
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    flash[:notice] = "Page #{@page.action} updated."
    redirect_to :action => :index
  end

  private

  def public_pages
    @page = Page.where(:action => params[:action]).last
  end
end
