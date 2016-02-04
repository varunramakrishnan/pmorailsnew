class HeirarchiesController < ApplicationController
  before_action :set_heirarchy, only: [:show, :edit, :update, :destroy]

  # GET /heirarchies
  # GET /heirarchies.json
  def index
    @heirarchies = Heirarchy.all
  end

  # GET /heirarchies/1
  # GET /heirarchies/1.json
  def show
  end

  # GET /heirarchies/new
  def new
    @heirarchy = Heirarchy.new
  end

  # GET /heirarchies/1/edit
  def edit
  end

  # POST /heirarchies
  # POST /heirarchies.json
  def create
    @heirarchy = Heirarchy.new(heirarchy_params)

    respond_to do |format|
      if @heirarchy.save
        format.html { redirect_to @heirarchy, notice: 'Heirarchy was successfully created.' }
        format.json { render json: {success: @heirarchy } }
      else
        format.html { render :new }
        format.json { render json: {error: @heirarchy.errors } }
      end
    end
  end

  # PATCH/PUT /heirarchies/1
  # PATCH/PUT /heirarchies/1.json
  def update
    respond_to do |format|
      if @heirarchy.update(heirarchy_params)
        format.html { redirect_to @heirarchy, notice: 'Heirarchy was successfully updated.' }
        format.json { render :show, status: :ok, location: @heirarchy }
      else
        format.html { render :edit }
        format.json { render json: @heirarchy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heirarchies/1
  # DELETE /heirarchies/1.json
  def destroy
    @heirarchy.destroy
    respond_to do |format|
      format.html { redirect_to heirarchies_url, notice: 'Heirarchy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heirarchy
      @heirarchy = Heirarchy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heirarchy_params
      params.require(:heirarchy).permit(:heirarchy_name)
    end
end
