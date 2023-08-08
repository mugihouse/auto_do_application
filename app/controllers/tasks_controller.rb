class TasksController < ApplicationController
  def new
    @task = Task.new()
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to root_path, success: 'タスクを登録しました'
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end
  
  private

  def task_params
    params.require(:task).permit(:title, :body, :time_required)
  end
end
