class SubjectsController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
    list
    render :list
  end
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  def new
    @subject = Subject.new(:name => 'default')
    @subject_count = Subject.count + 1
  end
  
  def create
    @subject = Subject.new(params[:subject]) #instantiate a new object using form parameters
    if @subject.save
      flash[:notice] = "Subject created"
      redirect_to(:action => 'list')
    else
      @subject_count = Subject.count + 1 # reinitializes so @subject_count is included in the new render of 'new'
      render('new') #if save fails redisplay form
    end
  end
  
  def edit
    @subject = Subject.find(params[:id])    
    @subject_count = Subject.count
  end
  
  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      flash[:notice] = "Subject updated"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      @subject_count = Subject.count
      render('edit') #if save fails redisplay form
    end
  end
  
  def delete
    @subject = Subject.find(params[:id])
  end
  
  def destroy
    Subject.find(params[:id]).destroy
    flash[:notice] = "Subject deleted"
    redirect_to(:action => 'list')
  end
  
end
