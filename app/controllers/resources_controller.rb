class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  

  # GET /resources
  # GET /resources.json
  def index
    resources = Resource.all
    result = []
    resources.each do |res|
      role=Role.where({id: res.heirarchy_id}).pluck(:role_name)[0]
      result << {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name, heirarchy_id: res.heirarchy_id, role: role, skill: res.skills.collect(&:skill_name).join(","), skill_id: res.skills.collect(&:id)}
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

  def filtered
    account = Account.find(params[:id])
    result = []
    arr = []
    allaccountservices=account.services
    allaccountservices.each do |ser|
      allskill=Skill.find_by_skill_name(ser.service_name)
      if allskill
        allskill.resources.each do |res|
          if arr.exclude? res.id
            arr << res.id
            result << {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name}
          end
        end
      end  
    end
    render json: result    
  end


  def occupied
    flag=1;
    values=[]
    occupiedresource = AccountResourceMapping.where(resource_id: params[:resources][:resource_id]).all 
     occupiedresource.each do |ser|
        values = ser.dates[1,ser.dates.length-2].split(",")
      end
       
    datenew=params[:resources][:Dates]  .to_s
             inValues=datenew[1,datenew.length-2].split(",")
             inValues.each do |inv|
              if values.include?(inv)
                flag=0
                break
              end
              if flag==0
                break
              end
             end
             render json: {success: flag ,dates: values}
  end

  def newoccupied
    newstr=[]
      params[:resources].each do |para|
        flag=1
        values=[]
              occupiedresource = AccountResourceMapping.where(resource_id: para[:resource_id]).where.not(account_id: para[:account_id]).all 
              percentage_loaded=0
              occupiedresource.each do |ser|
                values = values + ser.dates[1,ser.dates.length-2].delete(' ').split(",")
                percentage_loaded=percentage_loaded+ser[:percentage_loaded].to_i
              end
               datenew=para[:Dates].to_s
                 inValues=datenew[1,datenew.length-2].delete(' ').split(",")
                 inValues.each do |inv|
                  
                  if values.include?(inv) && (percentage_loaded+(para[:percentage_loaded].to_i) > 100)
                    flag=0
                    break
                  end
                  if flag==0
                    break
                  end
                 end
                  newstr << {resource_id: para[:resource_id],name:para[:name], success: flag ,dates: values}
      end

             render json: newstr
  end


  def allfiltered
    account = Account.find(params[:id])
    result = []
    arr = []
    allaccountservices=account.services
    allaccountservices.each do |ser|
      allskill=Skill.find_by_skill_name(ser.service_name)
      if allskill
        allskill.resources.each do |res|
          if arr.exclude? res.id
            arr << res.id
            result << {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name, group:'F'}
          end
        end
      end  
    end
    resources = Resource.all
    resources.each do |res|
      if arr.exclude? res.id
        arr << res.id
        result << {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name, group:'N'}
      end
    end
    render json: result    
  end 
    
  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end


  def findmanagers
    heirarchy=Role.where(id: "1").pluck(:heirarchy_id)
    res = Resource.where(heirarchy_id: heirarchy)
    render json: {success: res }
  end

  # POST /resources
  # POST /resources.json
  def create
    role=Role.find(resource_params[:heirarchy_id])
    @resource = Resource.create({employee_id: resource_params[:employee_id],employee_name: resource_params[:employee_name], heirarchy_id: resource_params[:heirarchy_id],role:  role.role_name})
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

  #POST accountdetails
  #POST accountdetails.json
    def accountdetails
        success = 0
        i=0
        message=inValues=arr=[]
        account = Account.find(params[:account][:id])
        updated = Account.update(params[:account][:id], :start_date => params[:account][:minEndDate], :end_date => params[:account][:maxEndDate])
        del=AccountResourceMapping.where(account_id: params[:account][:id]).all
          if del
            AccountResourceMapping.where(account_id: params[:account][:id]).all.destroy_all
          end
      if updated
        par = params[:account][:resources].to_a
        par.each do |s|
          resourcemap=AccountResourceMapping.where(resource_id: s[:resource_id]).where.not(account_id: params[:account][:id]).all
          update=AccountResourceMapping.where(resource_id: s[:resource_id]).where(account_id: params[:account][:id]).all
          if update
            AccountResourceMapping.where(resource_id: s[:resource_id]).where(account_id: params[:account][:id]).all.destroy_all
          end 
          arr=[]
          hashes = Hash.new
          if resourcemap
             resourcemap.each do |serv|
              newvalues = serv.dates[1,serv.dates.length-2].split(",")
              newvalues.each do |nvalue|
                 valdate=DateTime.strptime(nvalue.to_f.to_s[0,10],'%s');
                 vald=valdate.strftime("%d-%m-%y")
                 if hashes.key?(vald)
                   newval=hashes[vald].to_i+serv.percentage_loaded.to_i
                  hashes[vald]= newval 
                  # hashes[vald]= serv.percentage_loaded 
                else
                  hashes[vald]= serv.percentage_loaded     
                end
                 unless arr.include?(vald)
                   arr<<vald
                 end
              end
             end
             
              datenew=s[:Dates].to_s
             inValues=datenew[1,datenew.length-2].split(",")
             inValues.each do |inv|
                invaldate=DateTime.strptime(inv.to_f.to_s[0,10],'%s');
                invald=invaldate.strftime("%d-%m-%y")
                if hashes[invald]
                 newvar=hashes[invald]+s[:percentage_loaded].to_i
                 if newvar > 100
                  i=1
                  message << (Resource.find(s[:resource_id]).employee_name).to_s+" has already been allocated to some other project on the selected dates"
                  break
                 end
                end  
                
             end
             # if i==inValues.length
             #  t=1 
             # end
          end
              if i==0
                    ressave = AccountResourceMapping.create({resource_id: s[:resource_id], account_id: params[:account][:id] , percentage_loaded: s[:percentage_loaded],dates: s[:Dates]})                
                   # ressave =1
                   if ressave
                    message << (Resource.find(s[:resource_id]).employee_name).to_s+" has  been added to the project"
                   end
              end          
          
        end
      end

      render json: message
    end

  #POST resourcedates
  #POST resourcedates.json
def resourcedates
        success = 0
        results=[]
        resources = res_params[:resources].split(",")
        resources.each do |resource|
          hashes = Hash.new
          accountresource = AccountResourceMapping.where(resource_id: resource).all
                accountresource.each do |ser|
                resname=Resource.find(ser.resource_id).employee_name
                    values = ser.dates[1,ser.dates.length-2].split(",")
                          values.each do |value|
                                  if hashes.key?(value)
                                    newval=hashes[value]+ser.percentage_loaded.to_i
                                    hashes[value]= newval  
                                  else
                                    hashes[value]= ser.percentage_loaded.to_i     
                                 end
                           results << {title: resname + " "+ hashes[value].to_s, start: value}
                          end
                          # hashes.each do |h,v|
                          #   results << {title: resname + " "+ v.to_s, start: h}
                          # end  

                end
        end
      render json: results
    end

#POST skilldates
  #POST skilldates.json

    def skilldates
        success = 0
        results=[]
        resources=[]
        skills = ski_params[:skills].split(",")
        skills.each do |skill|
          res=ResourceSkillMapping.where(skill_id: skill).all
          res.each do |r|
            unless resources.include?(r.resource_id)
                  resources<<r.resource_id
            end
          end  

        end
                resources.each do |resource|
                  hashes = Hash.new
                  accountresource = AccountResourceMapping.where(resource_id: resource).all
                        accountresource.each do |ser|
                        resname=Resource.find(ser.resource_id).employee_name
                            values = ser.dates[1,ser.dates.length-2].split(",")
                                  values.each do |value|
                                    if hashes.key?(value)
                                    newval=hashes[value]+ser.percentage_loaded.to_i
                                    hashes[value]= newval  
                                  else
                                    hashes[value]= ser.percentage_loaded.to_i     
                                 end
                           results << {title: resname + " "+ hashes[value].to_s, start: value}
                                    # results << {title: resname, start: value}
                                  end
                        end
                end
      render json: results
    end
  #POST disenresourcedates
  #POST disenresourcedates.json
    def disenresourcedates
      success = 0
        results=[]
        nresults=[]
         resource = new_params[:id]
         account = new_params[:account]
         accountresource = AccountResourceMapping.where(resource_id: resource,account_id: account).all
         accountresource.each do |ser|
                resname=Resource.find(ser.resource_id).employee_name
                    values = ser.dates[1,ser.dates.length-2].split(",")
                          values.each do |value|
                            results << {title: resname, start: value}
                          end
          end
          noresource = AccountResourceMapping.where(resource_id: resource).where.not(account_id: account).where(percentage_loaded: 100).all
          noresource.each do |ner|
                resname=Resource.find(ner.resource_id).employee_name
                    values = ner.dates[1,ner.dates.length-2].split(",")
                          values.each do |value|
                            nresults << {title: resname, start: value}
                          end
          end
          render json: {dis: nresults,ena: results}

    end
  #POST new-dates
  def newdates
        success = 0
        results=[]
        resources=[]
        accountresources=[]
        skillresources=[]
        resources = date_params[:resources].split(",").map{ |s| s.to_i }
        accounts = date_params[:accounts].split(",")
        accounts.each do |account|
          accountresource = AccountResourceMapping.where(account_id: account).all
          accountresource.each do |ser|
            unless accountresources.include?(ser.resource_id)
                  accountresources<<ser.resource_id
            end
          end
        end
        skills = date_params[:skills].split(",")
        skills.each do |skill|
          res=ResourceSkillMapping.where(skill_id: skill).all
          res.each do |r|
            unless skillresources.include?(r.resource_id)
                  skillresources<<r.resource_id
            end
          end  

        end
        if(!accounts.any?)
          accountresources = Resource.all.collect(&:id)
        end
        if(!skills.any?)
          skillresources = Resource.all.collect(&:id)
        end
        if(!resources.any?)
          resources = Resource.all.collect(&:id)
        end
        intersectresources=accountresources & skillresources & resources
                intersectresources.each do |resource|
                  hashes = Hash.new
                  if(accounts.any?)
                  accountresource = AccountResourceMapping.where("account_id in (?)", accounts).where(resource_id: resource).all
                  else
                  accountresource = AccountResourceMapping.where(resource_id: resource).all
                  end
                        accountresource.each do |ser|
                        # resname=Resource.find(ser.resource_id).employee_name
                            values = ser.dates[1,ser.dates.length-2].delete(" ").split(",")
                                        values.each do |value|
                                          if hashes.key?(value)
                                            newval=hashes[value]+ser.percentage_loaded.to_i
                                            hashes[value]= newval  
                                          else
                                            hashes[value]= ser.percentage_loaded.to_i     
                                          end
                                          
                                          # results << {title: resname, start: value}
                                           # results << {title: resname + " "+ hashes[value].to_s, start: value}       
                                        end
                                  # results<< {title: values}  
                                       hashes.each do |key, array|
                                      # results << {title: resname + " "+ array.to_s, start: key}       
                                         # results << {title: key , start: array}       
                                       end
                                       
                        end
                        resname=Resource.find(resource).employee_name
                        hashes.each do |key, array|
                                      results << {title: resname + " "+ array.to_s, start: key}       
                                         # results << {title: key , start: array}       
                                       end
                            # results<< {title: hashes}
                                    # results<< {title: accountresources.any?}  

                end
      render json: results
      # render json: {"inter": intersectresources,"resources": resources,"accountresources": accountresources,"skillresources": skillresources}
    end

  #    def accountresources
  #     accounts = date_params[:accounts].split(",")
  #       accounts.each do |account|
  #         accountresource = AccountResourceMapping.where(account_id: account).all
  #         accountresource.each do |ser|
  #           unless resources.include?(ser.resource_id)
  #                 resources<<ser.resource_id
  #           end
  #         end
  #       end
     
  #    result = []
  #    arr = []
  #     accountresource.each do |ser|
  #       resname=Resource.find(ser.resource_id).employee_name
  #       values = ser.dates[1,ser.dates.length-2].split(",")
  #         values.each do |value|
  #           puts value
  #           result << {title: resname, start: value}
  #         end
       
  #     end
  #   render json: result    
  # end 
      
  #GET freeresources
  #GET freeresources.json
  def freeresources
      results=[]
      startdate=params[:startdate]
      enddate=params[:enddate]
      stdate=DateTime.strptime(startdate[0,10],'%s');
      endate=DateTime.strptime(enddate[0,10],'%s');
      #test
      resor=Resource.all
      resor.each do |res|
        newtemarr=[]
        newdate=stdate
        while ((newdate >= stdate) && (newdate <= endate)) do
                newd=newdate.strftime("%d-%m-%y")
                unless newtemarr.include?(newd)
                  newtemarr<<newd
                end
                newdate = newdate + 1.day
        end
        reshunmap=AccountResourceMapping.where(resource_id: res.id).where(percentage_loaded: 100).all
        reshunmap.each do |resh|
           newreshvalues = resh.dates[1,resh.dates.length-2].split(",")
           newreshvalues.each do |newreshv|
            newreshdate=DateTime.strptime(newreshv.to_f.to_s[0,10],'%s');
            newreshdatedmy=newreshdate.strftime("%d-%m-%y")
            if newtemarr.include?newreshdatedmy
              newtemarr.delete(newreshdatedmy)
            end
           end
        end
        ressevfmap=AccountResourceMapping.where(resource_id: res.id).where(percentage_loaded: 75).all
        ressevfmap.each do |resh|
           newreshvalues = resh.dates[1,resh.dates.length-2].split(",")
           newreshvalues.each do |newreshv|
            newreshdate=DateTime.strptime(newreshv.to_f.to_s[0,10],'%s');
            newreshdatedmy=newreshdate.strftime("%d-%m-%y")
            if newtemarr.include?newreshdatedmy
              newtemarr.delete(newreshdatedmy)
            end
           end
        end
        resfivfmap=AccountResourceMapping.where(resource_id: res.id).where(percentage_loaded: 50).all
        resfivfmap.each do |resh|
           newreshvalues = resh.dates[1,resh.dates.length-2].split(",")
           newreshvalues.each do |newreshv|
            newreshdate=DateTime.strptime(newreshv.to_f.to_s[0,10],'%s');
            newreshdatedmy=newreshdate.strftime("%d-%m-%y")
            if newtemarr.include?newreshdatedmy
              newtemarr.delete(newreshdatedmy)
            end
           end
        end
        newtemarr.each do |newv|
          newdreshdates=DateTime.strptime(newv,"%d-%m-%y")
          nreshd=newdreshdates.strftime("%s")
          results << {title: res.employee_name,start: (nreshd+('000'))}
        end

      end
              

       #with percentage
          resor=Resource.all
          resor.each do |res|
          resourcemap=AccountResourceMapping.where(resource_id: res.id).where.not(percentage_loaded: 100).all
          # resourcemap=AccountResourceMapping.where(resource_id: res.id).all
          if(resourcemap)
          hashes = Hash.new
          arr=[]
          resourcemap.each do |serv|

          newvalues = serv.dates[1,serv.dates.length-2].split(",")
          newdate = stdate
          newvalues.each do |nvalue|
             valdate=DateTime.strptime(nvalue.to_f.to_s[0,10],'%s');
             vald=valdate.strftime("%d-%m-%y")
              
             if hashes.key?(vald)
                newval=hashes[vald]+serv.percentage_loaded.to_i
               hashes[vald]= newval  
              else
               hashes[vald]= serv.percentage_loaded.to_i     
             end
             unless arr.include?(vald)
                arr<<vald
               end
          end
          end
                  arr.each do |myarr|
                    newdatess=DateTime.strptime(myarr,"%d-%m-%y")
                    newd=newdatess.strftime("%d-%m-%y")
                    news=newdatess.strftime("%s")
                    unless hashes[myarr] >=100
                      newstr=(100-hashes[myarr].to_f).to_s
                      results << {title: (res.employee_name+(" (")+(newstr[0,newstr.length-2])+("%)")),start: (news+('000'))}
                    end
                  end

                end
      end
      #without percentage


      #   resor=Resource.all
      #   resor.each do |res|
      #   # res=Resource.find(2)
      #   newarr=[]
      #   resmap=AccountResourceMapping.where(resource_id: res.id).all
      #   if(resmap)
      #     resmap.each do |ser|
      #       values = ser.dates[1,ser.dates.length-2].split(",")
      #       newdate = stdate
      #       arr=[]
        
      #         values.each do |value|
      #            valdate=DateTime.strptime(value.to_f.to_s[0,10],'%s');
      #            vald=valdate.strftime("%d-%m-%y")
      #            arr<<vald
      #           #results<<{id: value.to_f.to_s[0,10]}
      #         end

      #         while ((newdate >= stdate) && (newdate <= endate)) do
      #           newd=newdate.strftime("%d-%m-%y")
      #           unless arr.include?(newd)
      #             unless newarr.include?(newd)
      #             news=newdate.strftime("%s")
      #             results << {title: res.employee_name,start: (news+('000'))}
      #             end
      #           end
      #           newarr<<newd
                
      #           newdate = newdate + 1.day
      #         end
      #     end
      #   end
      # end

     



  #all
        # noresarr=[]
        # resmap = AccountResourceMapping.all
        # resmap.each do |r|
        #   unless noresarr.include?r.resource_id 
        #     noresarr<<r.resource_id 
        #   end
        # end
        # allresor=Resource.all
        # allresor.each do |res|
        #   unless noresarr.include?res.id 
        #     # noresarr<<r.resource_id 
        #     newdate = stdate
        #     while ((newdate >= stdate) && (newdate <= endate)) do
        #           news=newdate.strftime("%s")
        #           results << {title: res.employee_name,start: (news+('000'))}
        #         newdate = newdate + 1.day
        #       end

        #   end
        # end
    render json: results

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
    #def new_params
     # params.require(:account).permit(:id, :resources, :minEndDate, :maxEndDate)
    #end

     #def res_params
      #params.require(:resources).permit(:resource_id, :Dates)
    #end
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:employee_id, :employee_name, :role, :heirarchy_id, :skill, :resmodel)
    end
    def res_params
      params.permit(:resources)
    end
    def date_params
      params.permit(:resources,:skills,:accounts)
    end
    def ski_params
      params.permit(:skills)
    end
    def new_params
      params.require(:resources).permit(:id, :account)
    end

    
    

end
