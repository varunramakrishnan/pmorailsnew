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
          # TimeTrack.where({resource_id: resource_id, user_id: user_id,project_id: project_id,week_id: week_id}).all.destroy_all
        t[:dayHours][0][:Hours].each_with_index do |tnew,key|
         date = t[:dayHours][0][:day][key]
         hrs_logged = tnew
          status = t[:Status]
          temres = TimeTrack.where({resource_id: resource_id, user_id: user_id,project_id: project_id,week_id: week_id,date: date}).all
          if temres[0]
            if temres[0][:id]
              TimeTrack.update(temres[0][:id], :hrs_logged => hrs_logged, :status => status)
            end
          else
              TimeTrack.create({resource_id: resource_id, user_id: user_id,project_id: project_id,week_id: week_id,date: date,hrs_logged:  hrs_logged,status: status})
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
    # result = params[:data][:user][:user_id]
    hash = Hash.new
    statusHash = Hash.new
    newDatesHash = Hash.new
    newHoursHash = Hash.new

    fetch.each do |val|
      if ! hash.key?(val.project_id)
        hash[val.project_id] = Hash.new
      end
      if ! statusHash.key?(val.project_id)
        statusHash[val.project_id] = Hash.new
      end
      
        hash[val.project_id][val.date] = val.hrs_logged
        statusHash[val.project_id][val.date] = val.status
      # if !newDatesHash.key?(val.project_id)
      #   newDatesHash[val.project_id] = []
      # end
      # if !newHoursHash.key?(val.project_id)
      #   newHoursHash[val.project_id] = []
      # end
      #   newDatesHash[val.project_id] << val.date 
      #   newHoursHash[val.project_id] << val.hrs_logged 
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
     result << {userid: uid,username:username, timecard: timecard}

    # result << fetch.length
     # params[:data][:user].each do |t|
     #    t[:dayHours][0][:Hours].each_with_index do |tnew,key|
     #     date = t[:dayHours][0][:day][key]
     #    hrs_logged = tnew
     #    resource_id = params[:time_track][:user][:resource_id]
     #    user_id = params[:time_track][:user][:user_id]
     #    week_id = params[:time_track][:WeekID]
     #    project_id = t[:project_id]
     #    status = t[:Status]
     #    TimeTrack.create({resource_id: resource_id, user_id: user_id,project_id: project_id,hrs_logged: hrs_logged,date: date,week_id: week_id,status: status})
     #    end
     # end
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
        if hashes.key?(t[:project_id])
          hashes[t[:project_id]] += t[:hrs_logged]
        else
          hashes[t[:project_id]] = t[:hrs_logged]
        end
        
      end
      # hashes[timetrack[:project_id]] = timetrack[:hrs_logged]
      # result << timetrack
    end
    totutl=0
    hashes.each do |val,key| 
      if val == "0" 
        pname = "Other"
      else
        pname = Project.find(val)[:project_name]
      end
      perc = hashes[val]*100/total_hrs
      constr  = pname + " - " +perc.to_s + "%"
      label << constr
      data << hashes[val]
      totutl += hashes[val]
      # newt << perc
    end
      totperc = totutl*100/total_hrs
    # hashes.each { |key, value| label << key,data << newval}
         # render json: hashes
         render json: {"label": label,"doughdata": data,"totalutil": totperc}
         
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
