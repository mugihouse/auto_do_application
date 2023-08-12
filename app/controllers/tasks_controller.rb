class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update]

  def index
    @tasks = current_user.tasks.all
  end

  def new
    @task = Task.new()
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to task_path(@task), success: 'タスクを登録しました'
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), success: 'タスクを更新しました'
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :body, :time_required)
  end
end
