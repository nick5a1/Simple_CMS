class SectionsController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in
  before_filter :find_page
  
  def index
    list
    render('list')
  end
  
  def list
    @sections = Section.order("sections.position ASC").where(:page_id => @page.id)
  end
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new
    @section = Section.new(:name => 'default', :page_id => @page.id)
    @section_count = @page.sections.size + 1
    @pages = Page.order('position ASC')
  end
  
  def create
    @section = Section.new(params[:section]) #instantiate a new object using form parameters
    if @section.save
      flash[:notice] = "Section created"
      redirect_to(:action => 'list', :page_id => @section.page.id)
    else
      @section_count = @page.sections.size + 1
      @pages = Page.order('position ASC')
      render('new') #if save fails redisplay form
    end
  end
  
  def edit
    @section = Section.find(params[:id])
    @section_count = @page.sections.size
    @pages = Page.order('position ASC')
  end
  
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Section updated"
      redirect_to(:action => 'show', :id => @section.id, :page_id => @section.page.id)
    else
      @section_count = @page.sections.size
      @pages = Page.order('position ASC')
      render('edit') #if save fails redisplay form
    end
  end
  
  def delete
    @section = Section.find(params[:id])
  end
  
  def destroy
    Section.find(params[:id]).destroy
    flash[:notice] = "Section deleted"
    redirect_to(:action => 'list', :page_id => @page.id)
  end
  
  private
  
  def find_page
    if params[:page_id]
      @page = Page.where(:id => params[:page_id]).first
    end
  end
    
end
