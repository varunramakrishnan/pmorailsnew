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
        ad=AccountResourceMapping.where(resource_id: ser.resource_id,service_id: ser.service_id,account_id: params[:id])
        # ad.each do |eachres|
        #   result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: eachres[:dates], percentage_loaded: eachres[:percentage_loaded],service_id: eachres[:service_id], minDate: eachres[:dates][1,eachres[:dates].length-2].delete(' ').split(",").min.to_i,maxDate: eachres[:dates][1,eachres[:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
        # end  
        # result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: ad[0][:dates], percentage_loaded: ad[0][:percentage_loaded],service_id: ad[0][:service_id], minDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").min.to_i,maxDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
        sercode=Service.find(ad[0][:service_id]).service_code
        result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").map(&:to_i), percentage_loaded: ad[0][:percentage_loaded],service_id: ad[0][:service_id],service_code: sercode, minDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").min.to_i,maxDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
        
      end
    render json: result  
  end

  def modelresources 
    accountresource = AccountResourceMapping.where(account_id: params[:id]).all
    result = []
    ids=[]
    accountresource.each do |ser|
        unless ids.include?(ser.resource_id)
                    ids<<ser.resource_id
        resname=Resource.find(ser.resource_id)
        # ad=AccountResourceMapping.where(resource_id: ser.resource_id,service_id: ser.service_id,account_id: params[:id])
        # ad.each do |eachres|
        #   result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: eachres[:dates], percentage_loaded: eachres[:percentage_loaded],service_id: eachres[:service_id], minDate: eachres[:dates][1,eachres[:dates].length-2].delete(' ').split(",").min.to_i,maxDate: eachres[:dates][1,eachres[:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
        # end  
        result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,name: resname.employee_name }
        end

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
