class TimeTracksController < ApplicationController
  before_action :set_time_track, only: [:show, :edit, :update, :destroy]
  # before_filter :restrict_access 

  # GET /time_tracks
  # GET /time_tracks.json
  def index
    @time_tracks = TimeTrack.all
  end

  # GET /time_tracks/1
  # GET /time_tracks/1.json
  def show
  end

  # GET /time_tracks/new
  def new
    @time_track = TimeTrack.new
  end

  # GET /time_tracks/1/edit
  def edit
  end

  # POST /time_tracks
  # POST /time_tracks.json
  def create
    @time_track = TimeTrack.new(time_track_params)

    respond_to do |format|
      if @time_track.save
        format.html { redirect_to @time_track, notice: 'Time track was successfully created.' }
        format.json { render :show, status: :created, location: @time_track }
      else
        format.html { render :new }
        format.json { render json: @time_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_tracks/1
  # PATCH/PUT /time_tracks/1.json
  def update
    respond_to do |format|
      if @time_track.update(time_track_params)
        format.html { redirect_to @time_track, notice: 'Time track was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_track }
      else
        format.html { render :edit }
        format.json { render json: @time_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_tracks/1
  # DELETE /time_tracks/1.json
  def destroy
    @time_track.destroy
    respond_to do |format|
      format.html { redirect_to time_tracks_url, notice: 'Time track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def save_timecard
    result = 1
    temres = ""
    user_id = params[:time_track][:user][:user_id]
    week_id = params[:time_track][:WeekID]
    resource_id = params[:time_track][:user][:resource_id]
    if params[:time_track][:projects]
     params[:time_track][:projects].each do |t|
      project_id = t[:project_id]
      account_id = t[:account_id]
      service_id = t[:service_id]
          # TimeTrack.where({resource_id: resource_id, user_id: user_id,project_id: project_id,week_id: week_id}).all.destroy_all
        t[:dayHours][0][:Hours].each_with_index do |tnew,key|
         date = t[:dayHours][0][:day][key]
         hrs_logged = tnew
          status = t[:Status]
          comments = t[:comments]
          temres = TimeTrack.where({resource_id: resource_id, user_id: user_id,project_id: project_id,account_id: account_id,service_id: service_id,week_id: week_id,date: date}).all
          if temres[0]
            if temres[0][:id]
              TimeTrack.update(temres[0][:id], :hrs_logged => hrs_logged, :status => status,:comments => comments)
            end
          else
              TimeTrack.create({resource_id: resource_id, user_id: user_id,project_id: project_id,account_id: account_id,service_id: service_id,week_id: week_id,date: date,hrs_logged:  hrs_logged,status: status,:comments => comments})
          end
          
        end
     end
   end
    render json: result
  end



def get_timecard
    result = []
    uid = params[:data][:user][:user_id]
    wid = params[:data][:week_id]
    fetch = TimeTrack.where(user_id: uid,week_id: wid).all
    hash = Hash.new
    comhash = Hash.new
    fetch.each do |val|
      if ! hash.key?(val.account_id)
        hash[val.account_id] = Hash.new
        comhash[val.account_id] = Hash.new
      end
      if ! hash[val.account_id].key?(val.service_id)
        hash[val.account_id][val.service_id] = Hash.new
        comhash[val.account_id][val.service_id] = Hash.new
      end
      if ! hash[val.account_id][val.service_id].key?(val.project_id)
        hash[val.account_id][val.service_id][val.project_id] = Hash.new
      end
        comhash[val.account_id][val.service_id][val.project_id] = val.comments
        hash[val.account_id][val.service_id][val.project_id][val.date]  = val.hrs_logged
    end
    user = User.find(uid)
    res= Resource.find_by_employee_id(user.employee_id)
    if res
      username = res.employee_name
      else
        username = user.username
      end
    timecard = []
    timecard << hash
    comments = []
    comments << comhash
     result << {userid: uid,username:username, timecard: timecard,comments: comments}
    render json: result
  end

  def get_resource_pie_data
    hashes = Hash.new 
    label = []
    data = []
      if params[:dates].length == 1
        total_hrs = 8      
      elsif params[:dates].length == 7
        total_hrs = 40
      else
        total_hrs = 160
      end
      params[:dates].each do |date|
        timetrack = TimeTrack.where({resource_id: params[:rid], date: date})
        timetrack.each do |t|
            if ! hashes.key?(t[:account_id])
              hashes[t[:account_id]] = Hash.new
            end
            if !hashes[t[:account_id]].key?(t[:service_id])
              hashes[t[:account_id]][t[:service_id]] = Hash.new
            end
              if hashes[t[:account_id]][t[:service_id]].key?(t[:project_id])
                hashes[t[:account_id]][t[:service_id]][t[:project_id]] += t[:hrs_logged]
              else
                hashes[t[:account_id]][t[:service_id]][t[:project_id]] = t[:hrs_logged]
              end
        end
      end
      totutl=0


    #new code 
    hashes.each do |val,key| 
      key.each do |v,k| 
       k.each do |p,h|
         project_id = p
         account_id = val
         service_id = v
         hrs = h
         if p == "0"
          if val == 0
            account_code = "Other"
          else
            if Account.exists?(account_id)
              account_code = Account.find(account_id).account_code
            else
              account_code = "Account Not Found"
            end
          end
          if v == 0
            service_code = "OMC"
          else
            if Service.exists?(service_id)
              service_code = Service.find(service_id).service_code
            else
              service_code = "Service Not Found"
            end
          end
          project_name = account_code + " - " +  service_code
         else
          if Account.exists?(account_id)
              account_code = Account.find(account_id).account_code
          else
              account_code = "Account Not Found"
          end

          if Service.exists?(service_id)
            service_code = Service.find(service_id).service_code
          else
            service_code = "Service Not Found"
          end

          if Project.exists?(project_id)
              project_code = Project.find(project_id).project_code
          else
              project_code = "Project Not Found"
          end

          project_name = account_code + " - " + service_code + " - " + project_code
         end

         perc = h*100/total_hrs
        constr  = project_name + " - " +perc.to_s + "%"
        label << constr
        data << h
        totutl += h
       end
      end
    end

    totperc = totutl*100/total_hrs
    render json: {"label": label,"doughdata": data,"totalutil": totperc}
         
  end

  def get_report_data
    finaldata = []
    rids = []
    if params[:dates].length == 1
        total_hrs = 8      
      elsif params[:dates].length == 7
        total_hrs = 40
      else
        total_hrs = 160
      end
   resutil = 0
   if params[:resource]
    params[:resource].each do |r|
      rids << r[:id]
    end
    resources = Resource.where(id: rids)
    # resources = Resource.all
   else
    resources = Resource.all
   end

   
   util = 0
   res_hrs = resources.length * total_hrs
    resources.each do |res|
      data = []
      label = []
      ydata = []
      hashes = Hash.new
      params[:dates].each do |date|
        timetrack = TimeTrack.where({resource_id: res.id, date: date})
        timetrack.each do |t|
            if ! hashes.key?(t[:account_id])
              hashes[t[:account_id]] = Hash.new
            end
            if !hashes[t[:account_id]].key?(t[:service_id])
              hashes[t[:account_id]][t[:service_id]] = Hash.new
            end
              if hashes[t[:account_id]][t[:service_id]].key?(t[:project_id])
                hashes[t[:account_id]][t[:service_id]][t[:project_id]] += t[:hrs_logged]
              else
                hashes[t[:account_id]][t[:service_id]][t[:project_id]] = t[:hrs_logged]
              end
        end
      end
      totutl=0

      hashes.each do |val,key| 
          key.each do |v,k| 
               k.each do |p,h|
                 project_id = p
                 account_id = val
                 service_id = v
                 hrs = h
                   if p == "0"
                    if val == 0
                      account_code = "Other"
                    else
                      if Account.exists?(account_id)
                        account_code = Account.find(account_id).account_code
                      else
                        account_code = "Account Not Found"
                      end
                    end
                    if v == 0
                      service_code = "OMC"
                    else
                      if Service.exists?(service_id)
                        service_code = Service.find(service_id).service_code
                      else
                        service_code = "Service Not Found"
                      end
                    end
                    project_name = account_code + " - " +  service_code
                   else
                    if Account.exists?(account_id)
                        account_code = Account.find(account_id).account_code
                    else
                        account_code = "Account Not Found"
                    end

                    if Service.exists?(service_id)
                        service_code = Service.find(service_id).service_code
                      else
                        service_code = "Service Not Found"
                      end

                      if Project.exists?(project_id)
                          project_code = Project.find(project_id).project_code
                      else
                          project_code = "Project Not Found"
                      end


                    project_name = account_code + " - " + service_code + " - " + project_code
                   end

                 perc = h*100/total_hrs
                constr  = project_name + " - " +perc.to_s + "%"
                label << constr
                ydata << h
                y = h
                data << {"key": key,"y": y}
                totutl += h
                util += h
               end
          end
      end
      
      totperc = totutl*100/total_hrs
      if totperc < 50
        colour = "red"
      elsif totperc < 70
        colour = "yellow"
      elsif totperc < 85
        colour = "green"
      else
        colour = "red"
      end
      finaldata << {"name": res.employee_name,"emp_id": res.employee_id,"id": res.id,"spark": {"data": data,"label": label,"ydata": ydata},"hours": totutl.to_s + "/" + total_hrs.to_s,"perc": totperc,"colour": colour}
      
      # if arr.exclude? res.id
      #   arr << res.id
      #   result << {id: res.id, employee_id: res.employee_id, employee_name: res.employee_name, group:'N'}
      # end
    end
    resutil  = util.to_f*100/res_hrs.to_f
    render json: {donut: finaldata,util: resutil,total_hrs: res_hrs,util_hrs: util}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_track
      @time_track = TimeTrack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_track_params
      params.require(:time_track).permit(:user, :user_id, :project_id, :date, :status)
    end
end
