class AccountResourceMappingsController < ApplicationController
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
        resname=Resource.find(ser.resource_id).employee_name
        result << {id: ser.resource_id, employee_name: resname}
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
