class AccountResourceMappingsController < ApplicationController
  before_filter :restrict_access 
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def mappedresources 
    accountresource = AccountResourceMapping.where(account_id: params[:id]).all
    result = []
    accountresource.each do |ser|
        resname=Resource.find(ser.resource_id)
        ad=AccountResourceMapping.where(resource_id: ser.resource_id,account_id: params[:id])
        result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: ad[0][:dates], percentage_loaded: ad[0][:percentage_loaded], minDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").min.to_i,maxDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
      end
    render json: result  
  end

  def accountresources
     accountresource = AccountResourceMapping.where(account_id: params[:id]).all
     result = []
     arr = []
      accountresource.each do |ser|
        resname=Resource.find(ser.resource_id).employee_name
        values = ser.dates[1,ser.dates.length-2].split(",")
          values.each do |value|
            puts value
            result << {title: resname, start: value}
          end
       
      end
    render json: result    
  end 
end
