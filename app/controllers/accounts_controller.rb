class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  
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
      result << {id: res.id, account_name: res.account_name,account_code: res.account_code, organisational_unit_code: res.organisational_unit.unit_code, manager: man, resource_needed: res.resource_needed, status: res.status, services: res.services.collect(&:service_code).join(","),start_date: res.start_date, end_date: res.end_date, resource_needed: res.resource_needed, resource_allocated: res.resource_allocated, status: res.status,  request_type: res.request_type, region: res.region, location: res.location, contract_type: res.contract_type, customer_contact: res.customer_contact, other_persons: res.other_persons, other_sales_email: res.other_sales_email, sow_status: res.sow_status, comments: res.comments, anticipated_value: res.anticipated_value}
    end
    render json: result
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
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
    found = Account.find_by_account_name account_params[:account_name]
    saved=0
    if found
      account = Account.find_by_account_name(account_params[:account_name]).update(account_params)
      des = AccountServiceMapping.where(account_id: found.id).all.destroy_all
      saved=1
    else
      # account = Account.new(account_params)  
      account = Account.create({account_name:account_params[:account_name],account_code:account_params[:account_code],organisational_unit_id: account_params[:organisational_unit_id], start_date: account_params[:start_date], end_date: account_params[:end_date], resource_needed: account_params[:resource_needed], resource_allocated: account_params[:resource_allocated], resource_id: account_params[:resource_id], status: account_params[:status],  request_type: account_params[:request_type], region: account_params[:region], location: account_params[:location], contract_type: account_params[:contract_type], customer_contact: account_params[:customer_contact], other_persons: account_params[:other_persons], other_sales_email: account_params[:other_sales_email], sow_status: account_params[:sow_status], comments: account_params[:comments], anticipated_value: account_params[:anticipated_value] })  
      saved=1
    end
    #respond_to do |format|
      if saved
        res = Account.find_by_account_name account_params[:account_name]
        test=params[:sermodel].to_a
        test.each do |s| 
           AccountServiceMapping.create({account_id: res.id, service_id: s[:id]})
        end
       # format.html { redirect_to @account, notice: 'Account was successfully created.' }
       #format.html { render :new }
        #format.json { render :show, status: :created, location: saved }
        render json: saved
      else
       # format.html { render :new }
        #format.json { render json: @account.errors, status: :unprocessable_entity }
        render json: saved
      end
    #end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:account_name,:account_code, :organisational_unit_id, :start_date, :end_date, :resource_needed, :resource_allocated, :resource_id, :status, :sermodel, :request_type, :region, :location, :contract_type, :customer_contact, :other_persons, :other_sales_email, :sow_status, :comments, :anticipated_value, :anticipated_value_currency )
    end
end
