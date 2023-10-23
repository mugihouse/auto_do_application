class TasksController < ApplicationController
  before_action :login_required
  before_action :set_task, only: %i[show edit update change_status]

  def index
    @tasks = current_user.tasks.where(status: 0)
  end

  def show; end

  def new
    @task = Task.new()
  end

  def edit; end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to task_path(@task), success: t('defaults.messages.created', item: Task.model_name.human)
    else
      flash.now[:danger] = t('defaults.messages.not_created', item: Task.model_name.human)
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), success: t('defaults.messages.updated', item: Task.model_name.human)
    else
      flash.now[:danger] = t('defaults.messages.not_updated', item: Task.model_name.human)
      render :edit
    end
  end

  def change_status
    if @task.finish!
      redirect_to tasks_path, success: t('defaults.messages.destroyed', item: Task.model_name.human)
    else
      flash.now[:danger] = t('defaults.messages.not_destroyed', item: Task.model_name.human)
      render :show
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
