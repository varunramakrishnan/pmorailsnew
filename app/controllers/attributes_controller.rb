class AttributesController < ApplicationController
  before_action :set_attribute, only: [:show, :edit, :update, :destroy]

  # GET /attributes
  # GET /attributes.json
  def index
    @attributes = Attribute.all
  end

  # GET /attributes/1
  # GET /attributes/1.json
  def show
  end

  # GET /attributes/new
  def new
    @attribute = Attribute.new
  end

  # GET /attributes/1/edit
  def edit
  end

  # POST /attributes
  # POST /attributes.json
  def create
    @attribute = Attribute.new(attribute_params)

    respond_to do |format|
      if @attribute.save
        format.html { redirect_to @attribute, notice: 'Attribute was successfully created.' }
        format.json { render :show, status: :created, location: @attribute }
      else
        format.html { render :new }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attributes/1
  # PATCH/PUT /attributes/1.json
  def update
    respond_to do |format|
      if @attribute.update(attribute_params)
        format.html { redirect_to @attribute, notice: 'Attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @attribute }
      else
        format.html { render :edit }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attributes/1
  # DELETE /attributes/1.json
  def destroy
    @attribute.destroy
    respond_to do |format|
      format.html { redirect_to attributes_url, notice: 'Attribute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET Account Attributes
  def get_account_attributes
    regions = Attribute.where(attribute_type: "Region").where("active_status": "Y")
    sales_stage = Attribute.where(attribute_type: "Sales Stage").where("active_status": "Y")
    closure_probability = Attribute.where(attribute_type: "Closure Probability").where("active_status": "Y")
    owner = Attribute.where(attribute_type: "Owner").where("active_status": "Y")
    market_size = Attribute.where(attribute_type: "Market Size").where("active_status": "Y")
    currency = Attribute.where(attribute_type: "Currency").where("active_status": "Y")
    timezone = Attribute.where(attribute_type: "Timezone").where("active_status": "Y")
    sow_type = Attribute.where(attribute_type: "SOW Type").where("active_status": "Y")
    sow_status= Attribute.where(attribute_type: "SOW Status").where("active_status": "Y")
    account_sort= Attribute.where(attribute_type: "Account Sort").where("active_status": "Y")
    render json: {region: regions,sales_stage: sales_stage,closure_probability: closure_probability,owner: owner,market_size: market_size,currency: currency,timezone: timezone,sow_type: sow_type,sow_status: sow_status,account_sort: account_sort}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attribute
      @attribute = Attribute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attribute_params
      params.require(:attribute).permit(:attribute_type, :attribute_key, :attribute_value, :active_status)
    end
end
