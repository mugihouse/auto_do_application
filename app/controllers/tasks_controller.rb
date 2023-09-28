class TasksController < ApplicationController
  before_action :login_required
  before_action :set_task, only: %i[show edit update destroy change_status]

  def index
    @tasks = current_user.tasks.all.where(status: 0)
  end

  def show; end

  def new
    @task = Task.new()
  end

  def edit; end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to task_path(@task), success: 'タスクを登録しました'
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), success: 'タスクを更新しました'
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @notifications = Notification.where(task_id: @task.id)
    if @notifications
      @notifications.each do |notification|
        notification.update(task_id: nil)
      end
    end
    @task.destroy!
    redirect_to tasks_path, success: 'タスクを削除しました', status: :see_other
  end

  def change_status
    if @task.finish!
      redirect_to tasks_path, success: 'タスクを削除しました'
    else
      flash.now[:danger] = 'タスクの削除に失敗しました'
      render
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
