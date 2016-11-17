class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  # before_filter :restrict_access 
  # GET /accounts
  # GET /accounts.json
  def index
    accounts = Account.all
    result = []
    accounts.each do |res|
      if res.resource_id
        man = Resource.find(res.resource_id).employee_name;
      else
        man = "Null"
      end  
      # result << {id: res.id, account_name: res.account_name, organisational_unit_name: res.organisational_unit.unit_name, manager: man, resource_needed: res.resource_needed, status: res.status, services: res.services.collect(&:service_name).join(",")}
      result << {id: res.id, account_name: res.account_name,account_code: res.account_code, organisational_unit_code: res.organisational_unit.unit_code, manager: man, status: res.project_status, services: res.services.collect(&:service_code).join(","),   region: res.region, location: res.location, comments: res.comments,account_lob: res.account_lob,account_contact: res.account_contact,csm_contact: res.csm_contact,sales_contact: res.sales_contact,overall_health: res.overall_health}
    end
    render json: result
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  def account_services
    account = Account.find(params[:id])
    ser = []
    allser = []
    allservices=account.services
    allservices.each do |serv|
      ser << {id: serv.id,service_code: serv.service_code,mapping_format: serv.mapping_format}
      service = AccountServiceMapping.where(account_id: params[:id]).where(service_id: serv.id)
      # service.service_code = serv.service_code
      allser << service
    end 
    result = {service_id: ser,services: allser}
    render json: result
  end  

  def account_projects
    if params[:sid] == "undefined"
      pro = Project.where(account_id: params[:id])
    else
      pro = Project.where(account_id: params[:id],service_id: params[:sid])
    end
    projects=[]
    pro.each do |pr|
      owner=User.find(pr.createdBy).username
      projects << {id: pr.id,project_code: pr.project_code,project_name: pr.project_name,owner:owner}
      # service = AccountServiceMapping.where(account_id: params[:id]).where(service_id: serv.id)
      # service.service_code = serv.service_code
      # allser << service
    end 
    # result = {service_id: ser,services: allser}
    render json: projects
  end  
  

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
     account_params[:account_code] = account_params[:account_code].upcase!
     if Account.exists?(account_params[:id]) 
       @account = Account.find_by_id(account_params[:id]).update(account_params)
       account_id  =account_params[:id]
       des = AccountServiceMapping.where(account_id: account_id).all.destroy_all
     else
       @account = Account.create({account_name:account_params[:account_name],account_code:account_params[:account_code],organisational_unit_id: account_params[:organisational_unit_id], resource_id: account_params[:resource_id], project_status: account_params[:project_status],  region: account_params[:region], location: account_params[:location], csm_contact: account_params[:csm_contact], sales_contact: account_params[:sales_contact], overall_health: account_params[:overall_health], account_lob: account_params[:account_lob], comments: account_params[:comments], account_contact: account_params[:account_contact] })  
       account_id  = @account.id
     end
      # if saved
        # if account_params[:id]
        #   res = Account.find_by_id account_params[:id]
        # else
        #   res = account
        # end
        
        account_services=params[:services].to_a
         account_services.each do |s| 
            AccountServiceMapping.create({account_id: account_id, service_id: s[:id],start_date: s[:start_date],end_date: s[:end_date],request_date: s[:request_date],sow_signed_date: s[:sow_signed_date],no_of_people_needed: s[:no_of_people_needed],no_of_people_allocated: s[:no_of_people_allocated],contract_type: s[:contract_type],project_status: s[:project_status],sow_status: s[:sow_status],currency: s[:anticipated_value_currency],anticipated_value: s[:anticipated_value],actual_value: s[:actual_value],anticipated_usd_value: s[:anticipated_usd_value],actual_usd_value: s[:actual_usd_value],health: s[:health],comments: s[:comments]})
         end
         if @account.respond_to?('success')
            render json: {success: @account,errors: {}}         
         else
          render json: {success: @account,errors: @account.errors}
         end
         # if @account.respond_to?('success')
         #    render json: {success: @account.success}         
         # else
         #   if @account.respond_to?('errors')
         #    if @account.errors.length
         #     render json: {errors: @account.errors}
         #     else
         #      render json: {success: @account}
         #     end
         #   else
         #     render json: {success:@account, errors: @account}
         #   end
         # end
         
          
         # render json: account_id
      # else
      #    render json: saved
      # end
    # render json: saved
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    # respond_to do |format|
    #   if @account.update(account_params)
    #     format.html { redirect_to @account, notice: 'Account was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @account }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @account.errors, status: :unprocessable_entity }
    #   end
    # end
    if Account.exists?(account_params[:id]) 
       @account = Account.find_by_id(account_params[:id]).update(account_params)
       account_id  =account_params[:id]
       des = AccountServiceMapping.where(account_id: account_id).all.destroy_all
     end
        account_services=params[:services].to_a
         account_services.each do |s| 
            AccountServiceMapping.create({account_id: account_id, service_id: s[:id],start_date: s[:start_date],end_date: s[:end_date],request_date: s[:request_date],sow_signed_date: s[:sow_signed_date],no_of_people_needed: s[:no_of_people_needed],no_of_people_allocated: s[:no_of_people_allocated],contract_type: s[:contract_type],project_status: s[:project_status],sow_status: s[:sow_status],currency: s[:anticipated_value_currency],anticipated_value: s[:anticipated_value],actual_value: s[:actual_value],anticipated_usd_value: s[:anticipated_usd_value],actual_usd_value: s[:actual_usd_value],health: s[:health],comments: s[:comments]})
         end
          render json: {success: @account,errors: @account}
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  # get service startdate and end date from db
  def servicedates
    account = AccountServiceMapping.where(account_id: params[:account_id]).where(service_id:params[:service_id])
    render json: account
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:account_name,:account_code,:account_lob,:overall_health, :organisational_unit_id, :resource_id, :project_status, :sermodel,:services, :region, :location,  :csm_contact, :sales_contact, :account_contact, :comments,:id,:pm_contact )
    end
end
