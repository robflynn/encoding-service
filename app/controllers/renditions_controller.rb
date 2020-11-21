class RenditionsController < ApplicationController
  before_action :set_rendition, only: [:show, :update, :destroy]

  # GET /renditions
  # GET /renditions.json
  def index
    @renditions = Rendition.all
  end

  # GET /renditions/1
  # GET /renditions/1.json
  def show
  end

  # POST /renditions
  # POST /renditions.json
  def create
    @rendition = Rendition.new(rendition_params)

    if @rendition.save
      render :show, status: :created, location: @rendition
    else
      render json: @rendition.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /renditions/1
  # PATCH/PUT /renditions/1.json
  def update
    if @rendition.update(rendition_params)
      render :show, status: :ok, location: @rendition
    else
      render json: @rendition.errors, status: :unprocessable_entity
    end
  end

  # DELETE /renditions/1
  # DELETE /renditions/1.json
  def destroy
    @rendition.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rendition
      @rendition = Rendition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rendition_params
      params.require(:rendition).permit(:name, :description, :width, :height, :fps, :video_bitrate, :audio_bitrate, :container, :video_codec, :profile, :audio_codec)
    end
end
