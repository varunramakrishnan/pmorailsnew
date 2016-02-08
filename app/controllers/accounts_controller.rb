class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  
  # GET /accounts
  # GET /accounts.json
  def index
    accounts = Account.all
    result = []
    accounts.each do |res|
      man = Resource.find(res.resource_id).employee_name;
      result << {id: res.id, account_name: res.account_name, organisational_unit_name: res.organisational_unit.unit_name, manager: man, resource_needed: res.resource_needed, status: res.status, services: res.services.collect(&:service_name).join(",")}
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
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        res = Account.find_by_account_name account_params[:account_name]
        test=params[:sermodel].to_a
        test.each do |s| 
          AccountServiceMapping.create({account_id: res.id, service_id: s[:id]})
        end
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:account).permit(:account_name, :organisational_unit_id, :start_date, :end_date, :resource_needed, :resource_allocated, :resource_id, :status, :sermodel)
    end
end
