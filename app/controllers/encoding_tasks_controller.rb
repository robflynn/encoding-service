class EncodingTasksController < ApplicationController
  before_action :set_encoding_task, only: [:show, :update, :destroy]

  # GET /encoding_tasks
  # GET /encoding_tasks.json
  def index
    @encoding_tasks = EncodingTask.all
  end

  # GET /encoding_tasks/1
  # GET /encoding_tasks/1.json
  def show
  end

  # POST /encoding_tasks
  # POST /encoding_tasks.json
  def create
    @encoding_task = EncodingTask.new(encoding_task_params)

    if @encoding_task.save
      render :show, status: :created, location: @encoding_task
    else
      render json: @encoding_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /encoding_tasks/1
  # PATCH/PUT /encoding_tasks/1.json
  def update
    if @encoding_task.update(encoding_task_params)
      render :show, status: :ok, location: @encoding_task
    else
      render json: @encoding_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /encoding_tasks/1
  # DELETE /encoding_tasks/1.json
  def destroy
    @encoding_task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encoding_task
      @encoding_task = EncodingTask.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def encoding_task_params
      params.require(:encoding_task).permit(:name, :status, :output_store_id, :output_path)
    end
end
