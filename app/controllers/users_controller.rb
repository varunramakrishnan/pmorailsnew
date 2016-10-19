class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
  def search
    user = User.authenticate(params[:username], params[:password])
  if user
    access_token = SecureRandom.hex
    ApiKey.create({access_token: access_token})
  
  # user.resource_id=1
  if user.employee_id
    resource=Resource.find_by_employee_id(user.employee_id)
      
    if resource
      resource_id = resource.id
    else
      resource_id = 0
    end
  else
    resource_id = 0
  end
  end
    
    respond_to do |format|
    if user
      result = {id: user.id, username: user.username, employee_id: user.employee_id,resource_id: resource_id, role: user.role,created_at: user.created_at ,updated_at: user.updated_at}
      format.json { render json: {user: result,access_token: access_token } }
    #session[:user_id] = user.id
    #redirect_to root_url, :notice => "Logged in!"
    else
      format.json { render json: {user: "error" } }
    #flash.now.alert = "Invalid email or password"
    #render "new"
    end
    end
    #format.json { render json: {user: user }}
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new()
    @user.username = user_params[:username]
    @user.password = user_params[:password]
    @user.employee_id = user_params[:employee_id]
    res = Resource.find_by_employee_id(user_params[:employee_id])
    if res
     role = Role.find(res[:heirarchy_id])
    end
    if role
      if role[:heirarchy_id] == 1 
        @user.role = "pm"
      elsif role[:heirarchy_id] == 2 
        @user.role = "pl"
      end
    else
      @user.role = ""
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: {success: @user } }
      else
        format.html { render :new }
        format.json { render json: {error: @user.errors }}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :role, :employee_id)
    end
end
