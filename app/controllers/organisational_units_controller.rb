class OrganisationalUnitsController < ApplicationController
  before_action :set_organisational_unit, only: [:show, :edit, :update, :destroy]
  

  # GET /organisational_units
  # GET /organisational_units.json
  def index
    @organisational_units = OrganisationalUnit.all
  end

  # GET /organisational_units/1
  # GET /organisational_units/1.json
  def show
  end

  def services
    organisational_units = OrganisationalUnit.find(params[:id])
    services=organisational_units.services
    render json: {success: services }
  end 

  # GET /organisational_units/new
  def new
    @organisational_unit = OrganisationalUnit.new
  end

  # GET /organisational_units/1/edit
  def edit
  end

  # POST /organisational_units
  # POST /organisational_units.json
  def create
    @organisational_unit = OrganisationalUnit.new(organisational_unit_params)

    respond_to do |format|
      if @organisational_unit.save
        format.html { redirect_to @organisational_unit, notice: 'Organisational unit was successfully created.' }
        format.json { render json: {success: @organisational_unit } }
      else
        format.html { render :new }
        format.json { render json: {error: @organisational_unit.errors } }
      end
    end
  end

  # PATCH/PUT /organisational_units/1
  # PATCH/PUT /organisational_units/1.json
  def update
    respond_to do |format|
      if @organisational_unit.update(organisational_unit_params)
        format.html { redirect_to @organisational_unit, notice: 'Organisational unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @organisational_unit }
      else
        format.html { render :edit }
        format.json { render json: @organisational_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisational_units/1
  # DELETE /organisational_units/1.json
  def destroy
    @organisational_unit.destroy
    respond_to do |format|
      format.html { redirect_to organisational_units_url, notice: 'Organisational unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisational_unit
      @organisational_unit = OrganisationalUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisational_unit_params
      params.require(:organisational_unit).permit(:unit_name)
    end
end
