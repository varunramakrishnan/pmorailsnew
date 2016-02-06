class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  

  # GET /resources
  # GET /resources.json
  def index
    resources = Resource.all
    result = []
    resources.each do |res|
      result << {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name, heirarchy_id: res.heirarchy_id, role: res.role, skill: res.skills.collect(&:skill_name).join(","), skill_id: res.skills.collect(&:id)}
    end
    render json: result
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    resource = Resource.find(params[:id])
    skil = []
    allskills=resource.skills
    allskills.each do |ski|
      skil << {id: ski.id}
    end 
    result = {id: resource.id, employee_id: resource.employee_id, employee_name: resource.employee_name, heirarchy_id: resource.heirarchy_id, role: resource.role, skill: resource.skills.collect(&:skill_name).join(","), skill_id: skil}
    render json: result
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json

  def findmanagers
    heirarchy=Heirarchy.where(heirarchy_name: "Project Manager").pluck(:id)
    res = Resource.where(heirarchy_id: heirarchy)
    render json: {success: res }
  end
  def create
    @resource = Resource.new(resource_params)
    #skill = Skill.find(params[:skill])
    respond_to do |format|
      if @resource.save
        res = Resource.find_by_employee_id resource_params[:employee_id]
        test=params[:resmodel].to_a
        test.each do |s| 
          ResourceSkillMapping.create({resource_id: res.id, skill_id: s[:id]})
        end
        #mapping = ResourceSkillMapping.create({resource_id: res.id, skill_id: skill.id})
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render json: {success: @resource } }
      else
        format.html { render :new }
        format.json { render json: {error: @resource.errors } }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        res = Resource.find(params[:id])
        ResourceSkillMapping.where(resource_id: res.id).destroy_all
        test=params[:resmodel].to_a
        test.each do |s|
          ResourceSkillMapping.create({resource_id: res.id, skill_id: s[:id]})
        end
        result = {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name, heirarchy_id: res.heirarchy_id, role: res.role, skill: res.skills.collect(&:skill_name).join(",")}
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render json: {success: result } }
      else
        format.html { render :new }
        format.json { render json: {error: @resource.errors } }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: 'Resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:employee_id, :employee_name, :role, :heirarchy_id, :skill, :resmodel)
    end

    
    

end
