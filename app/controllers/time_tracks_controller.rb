class TimeTracksController < ApplicationController
  before_action :set_time_track, only: [:show, :edit, :update, :destroy]

  # GET /time_tracks
  # GET /time_tracks.json
  def index
    @time_tracks = TimeTrack.all
  end

  # GET /time_tracks/1
  # GET /time_tracks/1.json
  def show
  end

  # GET /time_tracks/new
  def new
    @time_track = TimeTrack.new
  end

  # GET /time_tracks/1/edit
  def edit
  end

  # POST /time_tracks
  # POST /time_tracks.json
  def create
    @time_track = TimeTrack.new(time_track_params)

    respond_to do |format|
      if @time_track.save
        format.html { redirect_to @time_track, notice: 'Time track was successfully created.' }
        format.json { render :show, status: :created, location: @time_track }
      else
        format.html { render :new }
        format.json { render json: @time_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_tracks/1
  # PATCH/PUT /time_tracks/1.json
  def update
    respond_to do |format|
      if @time_track.update(time_track_params)
        format.html { redirect_to @time_track, notice: 'Time track was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_track }
      else
        format.html { render :edit }
        format.json { render json: @time_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_tracks/1
  # DELETE /time_tracks/1.json
  def destroy
    @time_track.destroy
    respond_to do |format|
      format.html { redirect_to time_tracks_url, notice: 'Time track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_track
      @time_track = TimeTrack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_track_params
      params.require(:time_track).permit(:resource_id, :user_id, :project_id, :date, :status)
    end
end
