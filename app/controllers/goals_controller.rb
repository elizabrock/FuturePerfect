class GoalsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /goals
  # GET /goals.xml
  def index
    @goals = Goal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @goals }
    end
  end

  # GET /goals/1
  # GET /goals/1.xml
  def show
    @goal = Goal.find(params[:id])

    respond_to do |format|
      if @goal.user == current_user then
        format.html # show.html.erb
        format.xml  { render :xml => @goal }
      else
        format.html { redirect_to goals_path }
        format.xml { redirect_to goals_path }
      end
    end
  end

  # GET /goals/new
  # GET /goals/new.xml
  def new
    @goal = Goal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @goal }
    end
  end

  # GET /goals/1/edit
  def edit
    @goal = Goal.find(params[:id])
    
    if @goal.user != current_user
      redirect_to goals_path
    end
  end

  # POST /goals
  # POST /goals.xml
  def create
    @goal = Goal.new(params[:goal])
    @goal.user = current_user
    
    respond_to do |format|
      if @goal.save
        format.html { redirect_to(@goal, :notice => 'Goal was successfully created.') }
        format.xml  { render :xml => @goal, :status => :created, :location => @goal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /goals/1
  # PUT /goals/1.xml
  def update
    @goal = Goal.find(params[:id])

    respond_to do |format|
      if @goal.user != current_user 
        format.html { redirect_to goals_path }
        format.xml  { head :status => :unprocessable_entity }
      elsif @goal.update_attributes(params[:goal])
        format.html { redirect_to(@goal, :notice => 'Goal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.xml
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy if(@goal.user == current_user)
    

    respond_to do |format|
      format.html { redirect_to(goals_url) }
      format.xml  { head :ok }
    end
  end
end
