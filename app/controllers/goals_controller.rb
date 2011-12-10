class GoalsController < ApplicationController
  expose(:goals){ current_user.goals.all }
  expose(:goal)
  expose(:progress){ Progress.new }

  def index
    respond_to do |format|
      format.html
      format.json { render json: goals }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: goal }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render json: goal }
    end
  end

  def edit
  end

  def create
    goal.user = current_user
    respond_to do |format|
      if goal.save
        format.html { redirect_to :root, notice: 'Congratulations on your new goal!' }
        format.json { render json: goal, status: :created, location: goal }
      else
        format.html { render action: "new" }
        format.json { render json: goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if goal.update_attributes(params[:goal])
        format.html { redirect_to :root, notice: 'Your goal has been updated!' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: goal.errors, status: :unprocessable_entity }
      end
    end
  end
end
