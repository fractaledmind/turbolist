class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_tasks, only: %i[ index show ]

  # GET /tasks
  def index
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    # TODO: Ensure that toggling completion from the `details` section redirects to @task,
    # but toggling from the `main` section redirects to tasks_path.
    if @task.update(task_params)
      redirect_back fallback_location: @task, notice: "Task was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!
    redirect_to tasks_url, notice: "Task was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_tasks
      @tasks = Task.all.order(created_at: :desc)
      case params[:grouping]
      when "none" || "created_at"
        @tasks = @tasks.group_by { :IGNORE_ME }
      when "alphetical"
        @tasks = @tasks.order(title: :desc).group_by { :IGNORE_ME }
      when "list"
        @tasks = @tasks.group_by { |task| task.list&.title }
      when "label"
        @tasks = @tasks.unique_labels.map { |label| [label, Task.with_any_labels(label)] }.to_h
      else
        @tasks = @tasks.group_by { :IGNORE_ME }
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed, :list_id, labels: [], list_attributes: [:title])
    end
end
