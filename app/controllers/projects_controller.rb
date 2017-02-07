class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.joins(:account,:service).select("projects.*, accounts.account_name,services.service_name").all



    # result = []
    # @projects.each do |pro|
    #   # result << {id: res.id, account_name: res.account_name, organisational_unit_name: res.organisational_unit.unit_name, manager: man, resource_needed: res.resource_needed, status: res.status, services: res.services.collect(&:service_name).join(",")}
    #   result << {id: pro.id, account_name: res.account_name,account_code: res.account_code, organisational_unit_code: res.organisational_unit.unit_code, manager: man, status: res.project_status, services: res.services.collect(&:service_code).join(","),   region: res.region, location: res.location, comments: res.comments,account_lob: res.account_lob,account_contact: res.account_contact,csm_contact: res.csm_contact,sales_contact: res.sales_contact,overall_health: res.overall_health,actual_close_date: res.actual_close_date,actual_closed_month: res.actual_closed_month,annual_forecast: res.annual_forecast,closure_probability: res.closure_probability,currency: res.currency,expected_close_date: res.expected_close_date,expected_close_month: res.expected_close_month,market_size: res.market_size,owner: res.owner,received_date: res.received_date,sales_stage: res.sales_stage,time_zone: res.time_zone}
    # end
    # render json: result



  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    if @project.save
      pro=Project.find_by_project_code project_params[:project_code]
        Project.update(pro.id, :parent_id => pro.id,:version => 0)
    end
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filteredprojects
    pro = Project.where(service_id: params[:service_id],account_id: params[:account_id])
    render json: pro
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :project_code, :account_id, :service_id, :start_date,:end_date,:createdBy,:modifiedBy,:estimated_efforts)
    end
end
