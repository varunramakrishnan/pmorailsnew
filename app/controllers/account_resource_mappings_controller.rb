class AccountResourceMappingsController < ApplicationController
  # before_filter :restrict_access 
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
        ad=AccountResourceMapping.where(resource_id: ser.resource_id,percentage_loaded: ser.percentage_loaded,project_id: ser.project_id,service_id: ser.service_id,account_id: params[:id])
        # ad.each do |eachres|
        #   result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: eachres[:dates], percentage_loaded: eachres[:percentage_loaded],service_id: eachres[:service_id], minDate: eachres[:dates][1,eachres[:dates].length-2].delete(' ').split(",").min.to_i,maxDate: eachres[:dates][1,eachres[:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
        # end  
        # result << {id: ser.resource_id, resource_id: ser.resource_id, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: ad[0][:dates], percentage_loaded: ad[0][:percentage_loaded],service_id: ad[0][:service_id], minDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").min.to_i,maxDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1}
        sercode=Service.find(ad[0][:service_id]).service_code
        if ad[0][:project_id] != 0
          procode=Project.find(ad[0][:project_id]).project_code
        else  
          # procode=sercode
          procode=""
        end
        
        result << {id: ser.resource_id, resource_id: ser.resource_id,project_id: ser.project_id,project_code: procode, employee_name: resname.employee_name ,account_id: params[:id],name: resname.employee_name , Dates: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").map(&:to_i), percentage_loaded: ad[0][:percentage_loaded],service_id: ad[0][:service_id],service_code: sercode, minDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").min.to_i,maxDate: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").max.to_i ,saved: 1,noOfDays: ad[0][:dates][1,ad[0][:dates].length-2].delete(' ').split(",").length}
        
      end
    render json: result  
  end
  def delete_account_mapping 
    success=0
    del=AccountResourceMapping.where(account_id: params[:account][:id]).all
            if del
              AccountResourceMapping.where(account_id: params[:account][:id]).all.destroy_all
              success=1
            end
    render json: success  
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
        if (ser.project_id != 0)
          proname=Project.find(ser.project_id).project_code
        else
          proname=Service.find(ser.service_id).service_code
        end
        values = ser.dates[1,ser.dates.length-2].split(",")
          values.each do |value|
            puts value
            result << {title: resname + "-" +proname+"-"+ser.percentage_loaded.to_s, start: value}
          end
       
      end
    render json: result    
  end 

  def resource_projects
    resourceprojects = AccountResourceMapping.where(resource_id: params[:id]).all
    hash = Hash.new 
    resourceArray = []
    resourceprojects.each do |r|

      if hash[r.account_id]
        if hash[r.account_id][r.service_id]
            unless hash[r.account_id][r.service_id].include?(r.project_id)
              hash[r.account_id][r.service_id] << r.project_id
            end
        else
          hash[r.account_id][r.service_id] = []
           hash[r.account_id][r.service_id] << 0
          unless hash[r.account_id][r.service_id].include?(r.project_id)
            hash[r.account_id][r.service_id] << r.project_id
          end
        end
      else
        hash[r.account_id] = Hash.new 
        hash[r.account_id][r.service_id] = []
        hash[r.account_id][r.service_id] << 0
        unless hash[r.account_id][r.service_id].include?(r.project_id)
            hash[r.account_id][r.service_id] << r.project_id
        end
      end
    end

    hash.each do |val,key| 
      key.each do |v,k| 
       k.each do |p|
         project_id = p
         account_id = val
         service_id = v
         if p == 0
          project_name = Account.find(account_id).account_code + " - " + Service.find(service_id).service_code 
         else
          project_name = Account.find(account_id).account_code + " - " + Service.find(service_id).service_code + " - " + Project.find(project_id).project_code
         end
          resourceArray << {name: project_name,project_id: project_id,account_id: account_id,service_id: service_id,dayHours: [],temp: [],InputValue: [],tempLoop: [], bool: [], Status: ""}
       end
      end
    end


       resourceArray << {name: "Other",project_id: 0,account_id: 0 ,service_id: 0,dayHours: [],temp: [],InputValue: [],tempLoop: [], bool: [], Status: ""}
    render json: resourceArray
  end


  def check_availablity
    res=[]
    # resource = AccountResourceMapping.where.not(account_id: params[:account_id]).all
     acc = params[:check]
    params[:check].each do |key,value|
      value.each do |k,v|
        resource = AccountResourceMapping.where.not(account_id: params[:account_id]).where(resource_id: k).all
        # res<<resource
        per=0
        resource.each do |r|
          datearray = r[:dates][1,r[:dates].length-2].delete(' ').split(",")
          result = datearray.include?(key)
          if result
            per = per + r[:percentage_loaded]
          end
          res<<per  
        end  
      end 
      # res<<key
    end  
    # res<<arm_params[:check]
    render json:res
  end  
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def arm_params
  #     params.require(:arm).permit(:check,:account_id)
  #   end
end
