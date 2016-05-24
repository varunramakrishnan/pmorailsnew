class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access 

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
       service = Service.find(params[:id])
       ouid=OrganisationalUnitServiceMapping.where(service_id: service.id)
       if ouid[0]
         orid=ouid[0][:organisational_unit_id]
       else
         orid = 0
       end
       result = {id: service.id, service_name: service.service_name, service_code: service.service_code,organisational_unit_id: orid}
    render json: result
       # @service["organisational_unit_id"]=OrganisationalUnitServiceMapping.where(service_id: @service.id);
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    if @service.save
    ser=Service.find_by_service_name service_params[:service_name]
    OrganisationalUnitServiceMapping.create({organisational_unit_id: params[:unit_code].to_i, service_id: ser.id})
    ou=OrganisationalUnit.find(params[:unit_code].to_i)
    Skill.create({skill_type: ou.unit_name,skill_name: service_params[:service_name],skill_code: (ou.unit_code+service_params[:service_code])})
   end
    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render json: {success: @service } }
      else
        format.html { render :new }
        format.json { render json: {error: @service.errors } }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
        serv=Service.find(params[:id])
        Skill.where(skill_name: serv.service_name).destroy_all
      if @service.update(service_params)
        ser=Service.find(params[:id])
        OrganisationalUnitServiceMapping.where(service_id: params[:id]).destroy_all
        OrganisationalUnitServiceMapping.create({organisational_unit_id: params[:unit_code].to_i, service_id: params[:id]})
        ou=OrganisationalUnit.find(params[:unit_code].to_i)
        # s=Skill.where(skill_name: service_params[:service_name])
        # Skill.update(s.pluck(:id)[0],:skill_name => service_params[:service_name],:skill_code => (ou.unit_name+service_params[:service_code]),:skill_type =>  ou.unit_name)
        Skill.create({skill_type: ou.unit_name,skill_name: service_params[:service_name],skill_code: (ou.unit_code+service_params[:service_code])})
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:service_name, :service_code)
    end
end
