class PagesController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in
  before_filter :find_subject
  
  def index
    list
    render('list')
  end
  
  def list
    @pages = Page.sorted.where(:subject_id => @subject.id)
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new(:name => 'default', :subject_id => @subject.id)
    @page_count = @subject.pages.size + 1
    @subjects = Subject.order('position ASC')
  end
  
  def create
    @page = Page.new(params[:page]) #instantiate a new object using form parameters
    if @page.save
      flash[:notice] = "Page created"
      redirect_to(:action => 'list', :subject_id => @page.subject.id)
    else
      @page_count = @subject.pages.size + 1
      @subjects = Subject.order('position ASC')
      render('new') #if save fails redisplay form
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @page_count = @subject.pages.size
    @subjects = Subject.order('position ASC')
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Page updated"
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject.id)
    else
      @page_count = @subject.pages.size
      @subjects = Subject.order('position ASC')
      render('edit') #if save fails redisplay form
    end
  end
  
  def delete
    @page = Page.find(params[:id])
  end
  
  def destroy
    Page.find(params[:id]).destroy
    flash[:notice] = "Page deleted"
    redirect_to(:action => 'list', :subject_id => @subject.id)
  end
  
  private
  
  def find_subject
    puts ">>> #{params[:subject_id]}"
    if params[:subject_id]
      # @subject = Subject.where(:id => params[:subject_id]).first
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end

end
