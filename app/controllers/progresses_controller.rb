class ProgressesController < ApplicationController
  expose(:goals){ current_user.goals.all }
  expose(:goal)
  expose(:progresses){ goal.progresses.all }
  expose(:progress)

  def new
    respond_to do |format|
      format.html
      format.json { render json: progress }
    end
  end

  def create
    progress.goal = goal
    respond_to do |format|
      if progress.save
        format.html { redirect_to goal, notice: 'Woohoo! You made progress!' }
        format.json { render json: progress, status: :created, location: progress }
      else
        format.html { render "goals/show" }
        format.json { render json: progress.errors, status: :unprocessable_entity }
      end
    end
  end
end
